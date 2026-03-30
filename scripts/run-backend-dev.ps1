$go = 'D:\Program Files\Go1.23.1\bin\go.exe'
$projectRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$env:GOROOT = 'D:\Program Files\Go1.23.1'
$env:PATH = 'D:\Program Files\Go1.23.1\bin;' + $env:PATH
$env:GOTOOLCHAIN = 'local'
$env:GOCACHE = Join-Path $projectRoot '.gocache'
$env:GOTELEMETRY = 'off'

if (-not (Test-Path $go)) {
  Write-Error "Go not found: $go"
  exit 1
}

New-Item -ItemType Directory -Force -Path $env:GOCACHE | Out-Null

Push-Location $projectRoot
try {
  & $go run .\main.go
} finally {
  Pop-Location
}
