#!/usr/bin/env bash
# record.sh — Record demo.sh as an asciinema cast
#
# Usage:
#   ./demo/record.sh
#
# Output: demo/casts/demo.cast
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
CAST_DIR="${SCRIPT_DIR}/casts"
mkdir -p "${CAST_DIR}"

if ! command -v asciinema &>/dev/null; then
  echo "Error: asciinema is not installed."
  echo "Install it with: pip install asciinema"
  exit 1
fi

echo "Recording demo to ${CAST_DIR}/demo.cast ..."
asciinema rec "${CAST_DIR}/demo.cast" \
  --command "bash ${SCRIPT_DIR}/demo.sh" \
  --title "DataLad core loop: install → get → run → rerun" \
  --overwrite

echo "Done. Cast saved to ${CAST_DIR}/demo.cast"
