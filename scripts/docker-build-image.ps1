$ErrorActionPreference = 'Stop'

$projectRoot = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..'))
$imageTag = 'huobao-drama:latest'

docker build -t $imageTag $projectRoot

Write-Host "Docker image built: $imageTag"
