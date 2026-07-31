@{

# --------------------------------------------------
# Basic Module Information
# --------------------------------------------------

    RootModule = 'ReconTools.psm1'

    ModuleVersion = '0.1.0'

    GUID = '6f0a9d3e-1b82-4b4f-8d9a-7f8e2d5c4a11'

    Author = 'RollingGirl Project'

    CompanyName = 'RollingGirl'

    Copyright = '(c) 2026 RollingGirl'


    Description = @'
RollingGirl is a modular PowerShell reconnaissance engine.

Designed for authorized security assessments,
asset discovery, and defensive reconnaissance.

Built around project sessions,
state tracking, and extensible modules.
'@


    # --------------------------------------------------
    # PowerShell Requirements
    # --------------------------------------------------

    PowerShellVersion = '7.2'


    CompatiblePSEditions = @(
        'Core'
    )


    # --------------------------------------------------
    # Exported Commands
    # --------------------------------------------------

    FunctionsToExport = @(
        'Invoke-SubMap',
        'Invoke-WebProbe',
        'Invoke-PortScan',
        'Invoke-Recon',
        'Stop-Recon',
        'Get-RGInfo'
    )

    CmdletsToExport = @()

    VariablesToExport = @()

    AliasesToExport = @(
        'rollinggirl-find',
        'rollinggirl-look',
        'rollinggirl-run',
        'rollinggirl-again',
        'rollinggirl-stop',
        'rollinggirl-hello'
    )


    # --------------------------------------------------
    # Private Data
    # --------------------------------------------------

    PrivateData = @{

        PSData = @{

            Tags = @(
                'Recon',
                'Security',
                'OSINT',
                'PowerShell',
                'Automation'
            )


            ProjectUri = ''

            LicenseUri = ''


            ReleaseNotes = @'
Version 0.1.0

Initial RollingGirl engine release.

Features:
- Project system
- Module architecture
- Recon workflow foundation
- Command aliases
'@

        }

    }

}