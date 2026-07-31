# RollingGirl Architecture Plan

## Done

- PowerShell module manifest and root module
- Public/private function split
- Alias support
- Project object creation
- Workspace initialization
- State persistence to `state.json`
- Result/event tracking helpers
- Provider dispatcher
- Certificate, DNS, web, and port stages

## In progress

- Normalizing all provider outputs into richer project assets
- Reducing repeated state writes
- Making providers more resilient to network failures

## Next

1. Discovery expansion
   - Wayback
   - Archive sources
   - Search-based discovery
   - Wordlist expansion

2. Validation
   - DNS resolution
   - Alive checks
   - Record enrichment

3. HTTP enumeration
   - Response codes
   - Headers
   - TLS details
   - Titles

4. Technology detection
   - Server fingerprints
   - Framework detection
   - Favicon and script hints

5. Reporting
   - Markdown
   - HTML
   - JSON
   - CSV

## Long-term shape

```text
Project
├── Domains
├── Hosts
├── Services
├── URLs
├── Technologies
├── Ports
├── Certificates
├── DNS
├── Screenshots
└── Findings
```

## Goal

Turn RollingGirl from a set of commands into a full reconnaissance engine that keeps everything attached to one project object.
