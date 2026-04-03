#!/usr/bin/env bash
set -euo pipefail

APP_URL="${APP_URL:-http://127.0.0.1}"
RESET_ENDPOINT="${RESET_ENDPOINT:-${APP_URL%/}/public/resetem.cfm}"
EXTRA_RESET_HOOK="${EXTRA_RESET_HOOK:-}"

if [[ -n "$EXTRA_RESET_HOOK" ]]; then
  echo "Running extra reset hook: $EXTRA_RESET_HOOK"
  bash "$EXTRA_RESET_HOOK"
fi

if command -v curl >/dev/null 2>&1; then
  curl -fsS "$RESET_ENDPOINT"
elif command -v wget >/dev/null 2>&1; then
  wget -qO- "$RESET_ENDPOINT"
else
  echo "Need curl or wget to call $RESET_ENDPOINT" >&2
  exit 1
fi

echo
echo "resetem complete via $RESET_ENDPOINT"
