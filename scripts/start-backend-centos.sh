#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
APP_ROOT="${APP_ROOT:-${PROJECT_ROOT}}"
BINARY_PATH="${BINARY_PATH:-${APP_ROOT}/build/linux-amd64/huobao-drama-api}"
CONFIG_PATH="${CONFIG_PATH:-${APP_ROOT}/configs/config.yaml}"
LOG_DIR="${LOG_DIR:-${APP_ROOT}/logs}"
PID_FILE="${PID_FILE:-${LOG_DIR}/huobao-drama.pid}"
OUT_LOG="${OUT_LOG:-${LOG_DIR}/huobao-drama.out.log}"
ERR_LOG="${ERR_LOG:-${LOG_DIR}/huobao-drama.err.log}"

mkdir -p "${LOG_DIR}"

if [[ ! -f "${BINARY_PATH}" ]]; then
  echo "Binary not found: ${BINARY_PATH}" >&2
  exit 1
fi

if [[ ! -f "${CONFIG_PATH}" ]]; then
  echo "Config not found: ${CONFIG_PATH}" >&2
  exit 1
fi

if [[ -f "${PID_FILE}" ]]; then
  OLD_PID="$(cat "${PID_FILE}")"
  if [[ -n "${OLD_PID}" ]] && kill -0 "${OLD_PID}" 2>/dev/null; then
    echo "Service already running with PID ${OLD_PID}" >&2
    exit 1
  fi
  rm -f "${PID_FILE}"
fi

cd "${APP_ROOT}"
chmod +x "${BINARY_PATH}"

nohup "${BINARY_PATH}" >"${OUT_LOG}" 2>"${ERR_LOG}" &
NEW_PID=$!
echo "${NEW_PID}" > "${PID_FILE}"

echo "Started huobao-drama backend"
echo "PID: ${NEW_PID}"
echo "OUT_LOG: ${OUT_LOG}"
echo "ERR_LOG: ${ERR_LOG}"
