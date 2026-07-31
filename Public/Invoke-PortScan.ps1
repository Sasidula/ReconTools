function Invoke-PortScan {

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

    Write-RG "Port scanning $TargetHost" Info

    $ports = 80, 443, 8080, 8443
    foreach ($port in $ports) {
        $client = [System.Net.Sockets.TcpClient]::new()
        try {
            $async = $client.BeginConnect($TargetHost, $port, $null, $null)
            if ($async.AsyncWaitHandle.WaitOne(1500, $false) -and $client.Connected) {
                Add-RGResult -Project $Project -Type Port -Value "$port" -Source 'TCP' -Provider 'Invoke-PortScan' -Data @{
                    Host   = $TargetHost
                    State  = 'Open'
                    Port   = $port
                    Scheme = if ($port -in 443, 8443) { 'https' } else { 'http' }
                } | Out-Null
            }
        }
        catch {
            continue
        }
        finally {
            $client.Close()
        }
    }

    if (-not $Project.Progress.Ports.Started) {
        $Project.Progress.Ports.Started = Get-Date
    }
    $Project.Progress.Ports.Finished = Get-Date
    $Project.Progress.Ports.Success = $true

    Save-RGState $Project | Out-Null

    return $Project
}