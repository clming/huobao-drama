#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
IMAGE_TAG="${IMAGE_TAG:-huobao-drama:latest}"
CONTAINER_NAME="${CONTAINER_NAME:-huobao-drama}"
CONFIG_PATH="${CONFIG_PATH:-${PROJECT_ROOT}/configs/config.yaml}"
DATA_PATH="${DATA_PATH:-${PROJECT_ROOT}/data}"

mkdir -p "${DATA_PATH}"

if [[ ! -f "${CONFIG_PATH}" ]]; then
  echo "Config not found: ${CONFIG_PATH}" >&2
  exit 1
fi

if docker ps -aq -f "name=${CONTAINER_NAME}" | grep -q .; then
  docker rm -f "${CONTAINER_NAME}" >/dev/null
fi

docker run -d \
  --name "${CONTAINER_NAME}" \
  -p 5678:5678 \
  -v "${DATA_PATH}:/app/data" \
  -v "${CONFIG_PATH}:/app/configs/config.yaml:ro" \
  -e TZ=Asia/Shanghai \
  --restart unless-stopped \
  "${IMAGE_TAG}"

echo "Container started: ${CONTAINER_NAME}"
