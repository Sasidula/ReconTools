function Add-RGEvent {


    param(

        [Parameter(Mandatory)]
        [PSCustomObject]
        $Project,


        [Parameter(Mandatory)]
        [string]
        $Message

    )


    if (-not ($Project.PSObject.Properties.Name -contains 'Events')) {
        $Project |
            Add-Member `
                -MemberType NoteProperty `
                -Name Events `
                -Value @()
    }


    $Project.Events += [PSCustomObject]@{

        Time = Get-Date

        Message = $Message

    }


    Save-RGState $Project | Out-Null

}