#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

mkdir -p release
STAMP="$(date -u +%Y%m%d-%H%M%S)"
LATEST_ZIP="release/lead-manager-latest.zip"
STAMPED_ZIP="release/lead-manager-${STAMP}.zip"

TMP_LIST="$(mktemp)"
git ls-files > "$TMP_LIST"

zip -q "$STAMPED_ZIP" -@ < "$TMP_LIST"
cp "$STAMPED_ZIP" "$LATEST_ZIP"

rm -f "$TMP_LIST"

echo "ZIP created: $STAMPED_ZIP"
echo "ZIP latest:  $LATEST_ZIP"
