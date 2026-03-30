$node = 'D:\Users\cao_l\AppData\Local\nvm\v23.7.0\node.exe'
$vite = Join-Path $PSScriptRoot '..\web\node_modules\vite\bin\vite.js'
$vite = [System.IO.Path]::GetFullPath($vite)

if (-not (Test-Path $node)) {
  Write-Error "Node not found: $node"
  exit 1
}

if (-not (Test-Path $vite)) {
  Write-Error "Vite CLI not found: $vite"
  exit 1
}

Push-Location (Join-Path $PSScriptRoot '..\web')
try {
  & $node $vite
} finally {
  Pop-Location
}
