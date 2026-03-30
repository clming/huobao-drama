#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
OUTPUT_DIR="${PROJECT_ROOT}/build/linux-amd64"
IMAGE_TAG="${IMAGE_TAG:-huobao-drama-backend-builder:local}"
CONTAINER_NAME="${CONTAINER_NAME:-huobao-drama-backend-artifact}"

mkdir -p "${OUTPUT_DIR}"

docker build --target backend-builder -t "${IMAGE_TAG}" "${PROJECT_ROOT}"

if docker ps -aq -f "name=${CONTAINER_NAME}" | grep -q .; then
  docker rm -f "${CONTAINER_NAME}" >/dev/null
fi

docker create --name "${CONTAINER_NAME}" "${IMAGE_TAG}" >/dev/null
docker cp "${CONTAINER_NAME}:/app/build/linux-amd64/huobao-drama-api" "${OUTPUT_DIR}/huobao-drama-api"
docker rm -f "${CONTAINER_NAME}" >/dev/null

chmod +x "${OUTPUT_DIR}/huobao-drama-api"
echo "Linux backend binary exported: ${OUTPUT_DIR}/huobao-drama-api"
