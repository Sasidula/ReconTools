function Get-RGInfo {

    [CmdletBinding()]
    param()

    $module = Get-Module -Name ReconTools -ErrorAction SilentlyContinue

    [PSCustomObject]@{

        Name = "RollingGirl"

        Version = "0.1.0"

        Engine = "ReconTools"

        Author = "RollingGirl Project"

        PowerShell =
        $PSVersionTable.PSVersion.ToString()

        Loaded =
        $module.Name

        Path =
        $module.Path

    }

}