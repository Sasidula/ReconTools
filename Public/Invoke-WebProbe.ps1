function Invoke-WebProbe {

    [CmdletBinding(DefaultParameterSetName = 'Target')]
    param(
        [Parameter(Mandatory, Position = 0, ParameterSetName = 'Target')]
        [string]$Target,

        [Parameter(Mandatory, ParameterSetName = 'Project')]
        [PSCustomObject]$Project,

        [string]$RootPath = "$HOME\Recon"
    )

    if ($PSCmdlet.ParameterSetName -eq 'Target') {
        $TargetHost = Resolve-TargetHost $Target
        $Project = New-ReconProject -Target $Target -ResolvedHost $TargetHost -RootPath $RootPath
        $Project = Initialize-Project $Project
    }
    else {
        $TargetHost = $Project.Target.Host
    }

    if ([string]::IsNullOrWhiteSpace($TargetHost)) {
        Write-RG 'No target hostname.' Error
        return
    }

    Write-RG "Web probing $TargetHost" Info

    $uris = @(
        "https://$TargetHost/",
        "http://$TargetHost/"
    )

    foreach ($uri in $uris) {
        try {
            $response = Invoke-WebRequest -Uri $uri -Method Get -MaximumRedirection 5 -TimeoutSec 15 -ErrorAction Stop
            Add-RGResult -Project $Project -Type URL -Value $uri -Source 'HTTP' -Provider 'Invoke-WebProbe' -Data @{
                StatusCode = $response.StatusCode
                Server     = $response.Headers['Server']
                Title      = ([regex]::Match($response.Content, '<title>(.*?)</title>', 'IgnoreCase')).Groups[1].Value
            } | Out-Null
        }
        catch {
            continue
        }
    }

    if (-not $Project.Progress.HTTP.Started) {
        $Project.Progress.HTTP.Started = Get-Date
    }
    $Project.Progress.HTTP.Finished = Get-Date
    $Project.Progress.HTTP.Success = $true

    Save-RGState $Project | Out-Null

    return $Project
}