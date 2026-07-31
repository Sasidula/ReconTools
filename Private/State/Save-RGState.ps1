function Save-RGState {

    [CmdletBinding()]
    param(

        [Parameter(Mandatory)]
        [PSCustomObject]
        $Project

    )


    if (-not $Project.Paths.State) {

        throw "Project state path missing."

    }


    if (-not ($Project.PSObject.Properties.Name -contains "Updated")) {

        $Project |
                Add-Member `
            -MemberType NoteProperty `
            -Name Updated `
            -Value (Get-Date)

    }
    else {

        $Project.Updated = Get-Date

    }


    $Project |
        ConvertTo-Json -Depth 30 |
        Set-Content `
            -Path $Project.Paths.State `
            -Encoding UTF8


    Write-RG `
        "State updated." `
        Success


    return $Project
}