function New-ReconProject {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Target,

        [Parameter(Mandatory)]
        [string]$RootPath,

        [string]$ResolvedHost = $Target
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd_HHmmss"

    $projectRoot = Join-Path $RootPath $ResolvedHost
    $projectPath = Join-Path $projectRoot $timestamp

    [PSCustomObject]@{

        PSTypeName = 'RollingGirl.ReconProject'

        Version = '0.1.0'

        ProjectId = Get-Date -Format "yyyyMMdd-HHmmss"

        Meta = [PSCustomObject]@{
            SessionId    = [guid]::NewGuid().ToString()
            ModuleVersion = '0.1.0'
            Hostname     = $env:COMPUTERNAME
            User         = $env:USERNAME
        }

        Target = [PSCustomObject]@{
            Input = $Target
            Host  = $ResolvedHost
        }

        Paths = [PSCustomObject]@{
            Root        = $projectRoot
            Project     = $projectPath

            Raw         = Join-Path $projectPath 'raw'
            Processed   = Join-Path $projectPath 'processed'
            Reports     = Join-Path $projectPath 'reports'
            Logs        = Join-Path $projectPath 'logs'
            Screenshots = Join-Path $projectPath 'screenshots'

            State       = Join-Path $projectPath 'state.json'
        }

        Progress = [PSCustomObject]@{

            Initialized = $false

            SubMap = [PSCustomObject]@{
                Started  = $null
                Finished = $null
                Success  = $false
            }

            DNS = [PSCustomObject]@{
                Started  = $null
                Finished = $null
                Success  = $false
            }

            HTTP = [PSCustomObject]@{
                Started  = $null
                Finished = $null
                Success  = $false
            }

            Ports = [PSCustomObject]@{
                Started  = $null
                Finished = $null
                Success  = $false
            }

            Wayback = [PSCustomObject]@{
                Started  = $null
                Finished = $null
                Success  = $false
            }

            Nuclei = [PSCustomObject]@{
                Started  = $null
                Finished = $null
                Success  = $false
            }
        }

        Results = [PSCustomObject]@{

            Subdomains  = @()

            AliveHosts  = @()

            Technologies = @()

            Ports       = @()

            URLs        = @()

            Findings    = @()
        }

        Created = Get-Date

        Updated = Get-Date

        Events = @()
    }
}