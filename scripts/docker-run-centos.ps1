$ErrorActionPreference = 'Stop'

$projectRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$configPath = Join-Path $projectRoot 'configs\config.yaml'
$dataPath = Join-Path $projectRoot 'data'
$containerName = 'huobao-drama'
$imageTag = 'huobao-drama:latest'

New-Item -ItemType Directory -Force -Path $dataPath | Out-Null

if (-not (Test-Path $configPath)) {
  throw "Config not found: $configPath"
}

if ((docker ps -aq -f "name=$containerName")) {
  docker rm -f $containerName | Out-Null
}

docker run -d `
  --name $containerName `
  -p 5678:5678 `
  -v "${dataPath}:/app/data" `
  -v "${configPath}:/app/configs/config.yaml:ro" `
  -e TZ=Asia/Shanghai `
  --restart unless-stopped `
  $imageTag

Write-Host "Container started: $containerName"
