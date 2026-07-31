function Resolve-TargetHost {

    [CmdletBinding()]
    param(
        [Parameter(Mandatory)]
        [string]$Target
    )

    $Target = $Target.Trim()

    # If the user didn't include a scheme, assume HTTPS
    if ($Target -notmatch '^[a-zA-Z][a-zA-Z0-9+\-.]*://') {
        $Target = "https://$Target"
    }

    try {
        $Uri = [System.Uri]$Target
    }
    catch {
        throw "Invalid target '$Target'"
    }

    return $Uri.Host.ToLowerInvariant()
}