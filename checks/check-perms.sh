#!/usr/bin/env bash
set -euo pipefail

TARGET_DIR="${1:-$HOME/.openclaw}"

echo "Checking permissions under: $TARGET_DIR"

if [[ ! -d "$TARGET_DIR" ]]; then
  echo "FAIL: Missing directory $TARGET_DIR"
  exit 1
fi

stat -c "%a %n" "$TARGET_DIR"
stat -c "%a %n" "$TARGET_DIR/.env" "$TARGET_DIR/openclaw.json" 2>/dev/null || true

dir_perm="$(stat -c "%a" "$TARGET_DIR")"
if [[ "$dir_perm" != "700" ]]; then
  echo "WARN: $TARGET_DIR should be 700"
fi

for f in "$TARGET_DIR/.env" "$TARGET_DIR/openclaw.json"; do
  if [[ -f "$f" ]]; then
    perm="$(stat -c "%a" "$f")"
    if [[ "$perm" != "600" ]]; then
      echo "WARN: $f should be 600"
    fi
  else
    echo "WARN: Missing $f"
  fi
done

echo "Done."
