function Initialize-Project {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [PSCustomObject]$Project
    )


    Write-RG "Initializing project workspace..." Info


    # Create directories
    $folders = @(
        $Project.Paths.Project,
        $Project.Paths.Raw,
        $Project.Paths.Processed,
        $Project.Paths.Reports,
        $Project.Paths.Logs,
        $Project.Paths.Screenshots
    )


    foreach ($folder in $folders) {

        if (-not (Test-Path $folder)) {

            New-Item `
                -ItemType Directory `
                -Path $folder `
                -Force |
                    Out-Null

            Write-RG "Created $folder" Success
        }
    }


    # Update state
    $Project.Progress.Initialized = $true

    Save-RGState $Project | Out-Null


    return ,$Project
}