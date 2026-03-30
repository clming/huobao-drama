$ErrorActionPreference = 'Stop'

$projectRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$outputDir = Join-Path $projectRoot 'build\linux-amd64'
$imageTag = 'huobao-drama-backend-builder:local'
$containerName = 'huobao-drama-backend-artifact'
$binaryPath = Join-Path $outputDir 'huobao-drama-api'

New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

docker build --target backend-builder -t $imageTag $projectRoot

if ((docker ps -aq -f "name=$containerName")) {
  docker rm -f $containerName | Out-Null
}

docker create --name $containerName $imageTag | Out-Null
docker cp "${containerName}:/app/build/linux-amd64/huobao-drama-api" $binaryPath
docker rm -f $containerName | Out-Null

Write-Host "Linux backend binary exported: $binaryPath"
