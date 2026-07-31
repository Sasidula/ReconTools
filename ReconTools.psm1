# ReconTools.psm1

Write-Host @"

🎧 RollingGirl Recon Engine

Version : 0.1.0
Mode    : Project Recon
Status  : Online

"@ -ForegroundColor Cyan


# -----------------------------
# Load Private Functions
# -----------------------------

$PrivatePath = Join-Path $PSScriptRoot 'Private'

if (Test-Path $PrivatePath) {

    Get-ChildItem -Path $PrivatePath -Recurse -Filter '*.ps1' |
        Sort-Object FullName |
        ForEach-Object {

            Write-Verbose "Loading private: $($_.Name)"
            . $_.FullName
        }
}


# -----------------------------
# Load Public Functions
# -----------------------------

$PublicPath = Join-Path $PSScriptRoot 'Public'

if (Test-Path $PublicPath) {

    Get-ChildItem -Path $PublicPath -Filter '*.ps1' |
        Sort-Object FullName |
        ForEach-Object {

            Write-Verbose "Loading public: $($_.Name)"
            . $_.FullName
        }
}


# -----------------------------
# Load Aliases
# -----------------------------

$AliasFile = Join-Path $PSScriptRoot 'Aliases.ps1'

if (Test-Path $AliasFile) {

    . $AliasFile
}


# -----------------------------
# Export Public API
# -----------------------------

Export-ModuleMember `
    -Function @(
        'Invoke-SubMap',
        'Invoke-WebProbe',
        'Invoke-PortScan',
        'Invoke-Recon',
        'Stop-Recon',
        'Get-RGInfo'
    ) `
    -Alias @(
        'rollinggirl-find',
        'rollinggirl-look',
        'rollinggirl-run',
        'rollinggirl-again',
        'rollinggirl-stop',
        'rollinggirl-hello'
    )