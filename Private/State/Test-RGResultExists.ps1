function Test-RGResultExists {

    param(
        [PSCustomObject]$Project,
        [string]$Type,
        [string]$Value
    )

    $collection = switch ($Type) {
        'Subdomain' { $Project.Results.Subdomains }
        'Host' { $Project.Results.AliveHosts }
        'URL' { $Project.Results.URLs }
        'Port' { $Project.Results.Ports }
        'Technology' { $Project.Results.Technologies }
        'Finding' { $Project.Results.Findings }
        default { @() }
    }

    foreach ($item in @($collection)) {
        if ($null -eq $item) {
            continue
        }

        $itemValue = if ($item.PSObject.Properties.Name -contains 'Value') {
            $item.Value
        }
        else {
            $item
        }

        if ($itemValue -eq $Value) {
            return $true
        }
    }

    return $false
}