function Add-RGResult {


    [CmdletBinding()]

    param(

        [Parameter(Mandatory)]
        [PSCustomObject]
        $Project,


        [Parameter(Mandatory)]
        [ValidateSet(
                "Subdomain",
                "Host",
                "URL",
                "Port",
                "Technology",
                "Finding"
        )]
        [string]
        $Type,


        [Parameter(Mandatory)]
        [string]
        $Value,

        [string]$Source = "Unknown",

        [string]$Provider = "Unknown",

        [hashtable]$Data

    )

    if (Test-RGResultExists -Project $Project -Type $Type -Value $Value) {
        return
    }

    $Result = [PSCustomObject]@{
        Value      = $Value
        Type       = $Type
        Source     = $Source
        Provider   = $Provider
        Confidence = 100
        Time       = Get-Date
        Data       = $Data
    }

    switch ($Type) {
        'Subdomain' { $Project.Results.Subdomains += $Result }
        'Host' { $Project.Results.AliveHosts += $Result }
        'URL' { $Project.Results.URLs += $Result }
        'Port' { $Project.Results.Ports += $Result }
        'Technology' { $Project.Results.Technologies += $Result }
        'Finding' { $Project.Results.Findings += $Result }
    }


    Write-RG `
        "Added $Type : $Value" `
        Success


    Save-RGState $Project | Out-Null

}