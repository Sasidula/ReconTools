function Stop-Recon {

    [CmdletBinding()]
    param(
        [PSCustomObject]$Project
    )

    if ($Project) {
        Add-RGEvent -Project $Project -Message 'Recon stopped.' | Out-Null
        Save-RGState $Project | Out-Null
    }

    Write-RG "Recon stopped." Warning
}