function Invoke-RGProvider {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [PSCustomObject]$Project
    )

    $Provider = Get-RGProviders |
        Where-Object Name -eq $Name

    if (-not $Provider) {

        Write-RG "Unknown provider: $Name" Warning
        return
    }

    $command = Get-Command -Name $Provider.Function -CommandType Function -ErrorAction SilentlyContinue
    if (-not $command) {
        Write-RG "Provider function not found: $($Provider.Function)" Warning
        return
    }

    Write-RG "Running provider: $($Provider.Name)" Info

    & $Provider.Function -Project $Project
}