# 🎧 RollingGirl Recon Engine

RollingGirl is a project-centric PowerShell reconnaissance module built around a shared project object, persistent state, and modular discovery providers.

## Current status

- Module loads from `ReconTools.psm1` / `ReconTools.psd1`
- Public commands: `Invoke-SubMap`, `Invoke-WebProbe`, `Invoke-PortScan`, `Invoke-Recon`, `Stop-Recon`, `Get-RGInfo`
- Aliases: `rollinggirl-find`, `rollinggirl-look`, `rollinggirl-run`, `rollinggirl-again`, `rollinggirl-stop`, `rollinggirl-hello`
- Project workspaces are created automatically
- State is saved to `state.json`
- Discovery currently includes certificate, DNS, web, and port stages

## Import

```powershell
Import-Module .\ReconTools.psm1
Get-RGInfo
```

## Quick start

```powershell
Invoke-SubMap example.com
Invoke-WebProbe example.com
Invoke-PortScan example.com
Invoke-Recon example.com
```

## Project layout

```text
Recon/
└── example.com/
    └── 2026-07-11_220138/
        ├── raw/
        ├── processed/
        ├── reports/
        ├── logs/
        ├── screenshots/
        └── state.json
```

## Architecture

See [`ARCHITECTURE_PLAN.md`](./ARCHITECTURE_PLAN.md) for the engine plan, current implementation status, and next phases.

## Legal notice

Use RollingGirl only on systems you own or have explicit permission to assess.
