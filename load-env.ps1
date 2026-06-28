# Load .env into the current PowerShell session, then set dbt profile path.
Get-Content "$PSScriptRoot\.env" | ForEach-Object {
    if ($_ -match '^\s*([^#][^=]+)=(.*)$') {
        [Environment]::SetEnvironmentVariable($matches[1].Trim(), $matches[2].Trim(), 'Process')
    }
}
$env:DBT_PROFILES_DIR = "$PSScriptRoot\profiles"
Write-Host "Loaded .env and set DBT_PROFILES_DIR=$env:DBT_PROFILES_DIR"
