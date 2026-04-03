#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${REPO_DIR:-/opt/text-game-1}"
REPO_URL="${REPO_URL:-https://github.com/Doktur/text-game-1.git}"

if [[ -d "$REPO_DIR/.git" ]]; then
  echo "Updating repo in $REPO_DIR"
  git -C "$REPO_DIR" fetch origin main
  git -C "$REPO_DIR" checkout main
  git -C "$REPO_DIR" pull --ff-only origin main
else
  echo "Cloning repo into $REPO_DIR"
  mkdir -p "$(dirname "$REPO_DIR")"
  git clone "$REPO_URL" "$REPO_DIR"
fi

bash "$REPO_DIR/install_bundle.sh"
