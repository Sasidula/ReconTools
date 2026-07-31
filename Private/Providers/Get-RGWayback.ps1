function Get-RGWayback {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [PSCustomObject]
        $Project

    )

    $Domain = $Project.Target.Host
    if ([string]::IsNullOrWhiteSpace($Domain)) {
        Write-RG 'No target hostname.' Error
        return
    }

    Write-RG 'Wayback discovery started.' Info

    $queries = @(
        "https://web.archive.org/cdx/search/cdx?url=$Domain/*&output=json&fl=original&collapse=urlkey",
        "https://web.archive.org/cdx/search/cdx?url=*.$Domain/*&output=json&fl=original&collapse=urlkey"
    )

    $Response = foreach ($Uri in $queries) {
        try {
            Invoke-RestMethod -Uri $Uri -Method Get -TimeoutSec 20 -Headers @{ 'User-Agent' = 'Mozilla/5.0' } -ErrorAction Stop
        }
        catch {
            continue
        }
    }

    if (-not $Response) {
        Write-RG 'Wayback query failed.' Warning
        return
    }

    if ($Response.Count -lt 2) {
        Write-RG 'No Wayback entries found.' Warning
        return
    }

    $Hosts = $Response |
        Select-Object -Skip 1 |
        ForEach-Object {
            try {
                $original = if ($_ -is [System.Array]) { $_[0] } else { $_ }
                ([uri]$original).Host.ToLowerInvariant()
            }
            catch {
                $null
            }
        } |
        Where-Object {
            $_ -and $_ -match "$([regex]::Escape($Domain))$"
        } |
        ForEach-Object {
            $_ -replace '^\*\.', ''
        } |
        Sort-Object -Unique

    foreach ($Host in $Hosts) {
        Add-RGResult -Project $Project -Type Subdomain -Value $Host -Source 'Wayback' -Provider 'Get-RGWayback' | Out-Null
    }

    Write-RG "Found $($Hosts.Count) Wayback hosts." Success
}
