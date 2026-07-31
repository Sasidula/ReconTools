function Get-RGDns {

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

    Write-RG 'DNS discovery started.' Info

    if (-not (Get-Command Resolve-DnsName -ErrorAction SilentlyContinue)) {
        Write-RG 'Resolve-DnsName is unavailable.' Warning
        return
    }

    $prefixes = @(
        'www',
        'api',
        'dev',
        'test',
        'stage',
        'staging',
        'mail',
        'm',
        'support',
        'docs',
        'admin'
    )

    $candidates = @($Domain) + ($prefixes | ForEach-Object { "$_.$Domain" })

    foreach ($candidate in $candidates) {
        $records = @()
        foreach ($type in 'A', 'AAAA', 'CNAME') {
            try {
                $records += Resolve-DnsName -Name $candidate -Type $type -ErrorAction Stop
            }
            catch {
                continue
            }
        }

        if (-not $records) {
            continue
        }

        $addresses = @(
            $records |
                Where-Object IPAddress |
                Select-Object -ExpandProperty IPAddress -Unique
        )

        $cnameTargets = @(
            $records |
                Where-Object NameHost |
                Select-Object -ExpandProperty NameHost -Unique
        )

        if ($candidate -ne $Domain) {
            Add-RGResult -Project $Project -Type Subdomain -Value $candidate -Source 'DNS' -Provider 'Get-RGDns' -Data @{
                RecordTypes = ($records.QueryType | Sort-Object -Unique)
                Addresses   = $addresses
                CNames      = $cnameTargets
            } | Out-Null
        }

        foreach ($address in $addresses) {
            Add-RGResult -Project $Project -Type Host -Value $address -Source 'DNS' -Provider 'Get-RGDns' -Data @{
                Host        = $candidate
                RecordTypes = ($records.QueryType | Sort-Object -Unique)
            } | Out-Null
        }
    }

    Write-RG 'DNS discovery finished.' Success
}