function Load-RGState {

    [CmdletBinding()]

    param(

        [Parameter(Mandatory)]
        [string]
        $Path

    )


    if (-not (Test-Path $Path)) {

        throw "State file not found: $Path"

    }


    $Project = Get-Content `
        -Path $Path `
        -Raw |
            ConvertFrom-Json


    Write-RG `
        "Project loaded." `
        Success


    return $Project

}