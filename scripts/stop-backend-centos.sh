#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "${SCRIPT_DIR}/.." && pwd)"
APP_ROOT="${APP_ROOT:-${PROJECT_ROOT}}"
LOG_DIR="${LOG_DIR:-${APP_ROOT}/logs}"
PID_FILE="${PID_FILE:-${LOG_DIR}/huobao-drama.pid}"

if [[ ! -f "${PID_FILE}" ]]; then
  echo "PID file not found: ${PID_FILE}"
  exit 0
fi

PID="$(cat "${PID_FILE}")"
if [[ -z "${PID}" ]]; then
  echo "PID file is empty: ${PID_FILE}" >&2
  exit 1
fi

if kill -0 "${PID}" 2>/dev/null; then
  kill "${PID}"
  echo "Stopped huobao-drama backend: ${PID}"
else
  echo "Process not running: ${PID}"
fi

rm -f "${PID_FILE}"
