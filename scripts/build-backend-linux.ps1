$ErrorActionPreference = 'Stop'

$go = 'D:\Program Files\Go1.23.1\bin\go.exe'
$projectRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$outputDir = Join-Path $projectRoot 'build\linux-amd64'
$binaryName = 'huobao-drama-api'
$binaryPath = Join-Path $outputDir $binaryName

if (-not (Test-Path $go)) {
  throw "Go not found: $go"
}

New-Item -ItemType Directory -Force -Path $outputDir | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $projectRoot '.gocache-linux') | Out-Null

Push-Location $projectRoot
try {
  $env:GOROOT = 'D:\Program Files\Go1.23.1'
  $env:PATH = 'D:\Program Files\Go1.23.1\bin;' + $env:PATH
  $env:GOTOOLCHAIN = 'local'
  $env:GOCACHE = Join-Path $projectRoot '.gocache-linux'
  $env:GOOS = 'linux'
  $env:GOARCH = 'amd64'
  $env:CGO_ENABLED = '0'

  & $go build -trimpath -ldflags='-s -w' -o $binaryPath .\main.go

  Write-Host "Linux binary created: $binaryPath"
} finally {
  Pop-Location
}
