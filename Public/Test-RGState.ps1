function Test-RGState {

    param(
        [Parameter(Mandatory)]
        $Project
    )


    [PSCustomObject]@{

        Project =
        $Project.ProjectId

        Results =
        $Project.Results

        StateFile =
        Test-Path $Project.Paths.State

        Updated =
        $Project.Updated

    }

}