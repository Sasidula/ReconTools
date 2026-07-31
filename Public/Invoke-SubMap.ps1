function Invoke-SubMap {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Target,

        [string]$RootPath = "$HOME\Recon"
    )


    Write-RG "Rolling Girl is listening..." Info


    try {
        $HostName = Resolve-TargetHost $Target
    }
    catch {
        Write-RG $_.Exception.Message Error
        return
    }

    if (-not $HostName) {

        Write-RG "Unable to resolve target." Error
        return

    }


    Write-RG "Target : $HostName" Success


    $Project = New-ReconProject `
        -Target $Target `
        -ResolvedHost $HostName `
        -RootPath $RootPath


    try {

        $Project = Initialize-Project $Project

    }
    catch {

        Write-RG $_.Exception.Message Error
        return

    }

    Write-RG "Project ready." Success

    Add-RGEvent -Project $Project -Message 'SubMap discovery started.' | Out-Null

    $Providers = Get-RGProviders |
        Where-Object Enabled |
        Sort-Object Priority

    foreach ($Provider in $Providers) {

        Invoke-RGProvider `
            -Name $Provider.Name `
            -Project $Project
    }

    Add-RGEvent -Project $Project -Message 'SubMap discovery finished.' | Out-Null

    $Project.Progress.SubMap.Started = $Project.Progress.SubMap.Started ?? (Get-Date)
    $Project.Progress.SubMap.Finished = Get-Date
    $Project.Progress.SubMap.Success = $true

    Save-RGState $Project | Out-Null

    Write-Host ""
    Write-Host "Project:"
    Write-Host $Project.Paths.Project `
        -ForegroundColor Cyan

    return $Project
}