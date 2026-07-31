function Get-RGCertificate {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [PSCustomObject]
        $Project

    )

    Write-RG "Certificate discovery started." Info

    $Domain = $Project.Target.Host

    if ([string]::IsNullOrWhiteSpace($Domain)) {

        Write-RG "No target hostname." Error
        return

    }

    Write-RG "Checking Certificate Transparency logs..." Info

    $Uri = "https://crt.sh/?q=%25.$Domain&output=json"
    $Headers = @{
        'User-Agent' = 'Mozilla/5.0'
    }

    $Response = $null
    foreach ($attempt in 1..2) {
        try {
            $Response = Invoke-RestMethod `
                -Uri $Uri `
                -Method Get `
                -Headers $Headers `
                -TimeoutSec 20 `
                -ErrorAction Stop
            break
        }
        catch {
            if ($attempt -eq 2) {
                Write-RG "Failed to query crt.sh." Error
                return
            }
        }
    }

    if (-not $Response) {

        Write-RG "No certificate entries found." Warning
        return

    }

    $Hosts = $Response |
        ForEach-Object { $_.name_value -split "`n" } |
        ForEach-Object { $_.Trim().ToLowerInvariant() } |
        Where-Object {
            $_ -and
            $_ -notmatch '\s|@' -and
            $_ -match "$([regex]::Escape($Domain))$"
        } |
        ForEach-Object {
            $_ -replace '^\*\.', ''
        } |
        Sort-Object -Unique

    foreach ($Host in $Hosts) {

        Add-RGResult `
            -Type Subdomain `
            -Value $Host `
            -Source 'crt.sh' `
            -Provider 'Get-RGCertificate' `
            -Project $Project |
                Out-Null

    }

    Write-RG "Found $($Hosts.Count) unique subdomains." Success

}