Set-Location (Join-Path $PSScriptRoot "..\flowise")
$env:PORT = "3000"
$env:FLOWISE_USERNAME = "admin"
# Set FLOWISE_PASSWORD in your environment before running; never commit it.
if (-not $env:FLOWISE_PASSWORD) { Write-Error "Set FLOWISE_PASSWORD first, e.g.  `$env:FLOWISE_PASSWORD = '<long random password>'"; exit 1 }
.\node_modules\.bin\flowise start --port=3000 --host=127.0.0.1
