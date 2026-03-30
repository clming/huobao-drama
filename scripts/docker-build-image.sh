#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
IMAGE_TAG="${IMAGE_TAG:-huobao-drama:latest}"

docker build -t "${IMAGE_TAG}" "${PROJECT_ROOT}"
echo "Docker image built: ${IMAGE_TAG}"
