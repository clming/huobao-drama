#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
OUTPUT_DIR="${PROJECT_ROOT}/build/linux-amd64"
BINARY_PATH="${OUTPUT_DIR}/huobao-drama-api"

mkdir -p "${OUTPUT_DIR}"
mkdir -p "${PROJECT_ROOT}/.gocache-linux"

cd "${PROJECT_ROOT}"

export GOTOOLCHAIN=local
export GOCACHE="${PROJECT_ROOT}/.gocache-linux"
export GOOS=linux
export GOARCH=amd64
export CGO_ENABLED=0

go build -trimpath -ldflags="-s -w" -o "${BINARY_PATH}" ./main.go

chmod +x "${BINARY_PATH}"
echo "Linux binary created: ${BINARY_PATH}"
