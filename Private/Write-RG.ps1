function Write-RG {

    param(
        [Parameter(Mandatory)]
        [string]$Message,

        [ValidateSet(
                'Info',
                'Success',
                'Warning',
                'Error'
        )]
        [string]$Level = 'Info'
    )

    switch ($Level) {

        'Info' {
            Write-Host "🎧 [INFO ] $Message" -ForegroundColor Cyan
        }

        'Success' {
            Write-Host "🎵 [ OK  ] $Message" -ForegroundColor Green
        }

        'Warning' {
            Write-Host "⚠️  [WARN ] $Message" -ForegroundColor Yellow
        }

        'Error' {
            Write-Host "❌ [FAIL ] $Message" -ForegroundColor Red
        }
    }
}