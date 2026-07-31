function Get-RGProviders {

    [CmdletBinding()]
    param()

    @(
        [PSCustomObject]@{
            Name     = 'Certificate'
            Function = 'Get-RGCertificate'
            Enabled  = $true
            Priority = 10
        }

        [PSCustomObject]@{
            Name     = 'Wayback'
            Function = 'Get-RGWayback'
            Enabled  = $false
            Priority = 20
        }

        [PSCustomObject]@{
            Name     = 'DNS'
            Function = 'Get-RGDns'
            Enabled  = $true
            Priority = 30
        }

        [PSCustomObject]@{
            Name     = 'Archive'
            Function = 'Get-RGArchive'
            Enabled  = $false
            Priority = 40
        }

        [PSCustomObject]@{
            Name     = 'AlienVault'
            Function = 'Get-RGAlienVault'
            Enabled  = $false
            Priority = 50
        }
    )
}