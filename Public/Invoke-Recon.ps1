function Invoke-Recon {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Target,

        [string]$RootPath = "$HOME\Recon"
    )

    Write-RG "Running full recon for $Target" Info

    $Project = Invoke-SubMap -Target $Target -RootPath $RootPath
    if (-not $Project) {
        return
    }

    Invoke-WebProbe -Project $Project | Out-Null
    Invoke-PortScan -Project $Project | Out-Null

    Save-RGState $Project | Out-Null

    return $Project
}