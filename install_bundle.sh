#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ZIP_NAME="shattered_round17_installed_bugfixes_phoenix_dashboard.zip"
REPO_RAW_URL="${REPO_RAW_URL:-https://raw.githubusercontent.com/Doktur/text-game-1/main/${ZIP_NAME}}"
INSTALL_ROOT="${INSTALL_ROOT:-/var/www}"
APP_DIR="${APP_DIR:-${INSTALL_ROOT}/shattered}"
WORK_DIR="${WORK_DIR:-/tmp/shattered-deploy}"
LOCAL_ZIP="${ZIP_PATH:-${SCRIPT_DIR}/${ZIP_NAME}}"

mkdir -p "$WORK_DIR" "$INSTALL_ROOT"

require_cmd() {
  command -v "$1" >/dev/null 2>&1 || {
    echo "Missing required command: $1" >&2
    exit 1
  }
}

require_cmd bash
require_cmd unzip

if [[ -f "$LOCAL_ZIP" ]]; then
  ZIP_TO_INSTALL="$LOCAL_ZIP"
  echo "Using local bundle: $ZIP_TO_INSTALL"
else
  require_cmd curl
  ZIP_TO_INSTALL="$WORK_DIR/$ZIP_NAME"
  echo "Downloading bundle from GitHub: $REPO_RAW_URL"
  curl -fL "$REPO_RAW_URL" -o "$ZIP_TO_INSTALL"
fi

echo "Extracting bundle into $INSTALL_ROOT"
unzip -oq "$ZIP_TO_INSTALL" -d "$INSTALL_ROOT"

mkdir -p "$APP_DIR"
cp "$SCRIPT_DIR/resetem.sh" "$APP_DIR/resetem.sh"
chmod +x "$APP_DIR/resetem.sh"

echo "Running reset hook"
bash "$APP_DIR/resetem.sh"

echo "Install complete: $APP_DIR"
