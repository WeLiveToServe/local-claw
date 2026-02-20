#!/usr/bin/env bash
set -euo pipefail

ROOT="${1:-.}"
cd "$ROOT"

echo "Scanning repo for common secret patterns..."

PATTERN='OPENAI_API_KEY|ANTHROPIC_API_KEY|GEMINI_API_KEY|XAI_API_KEY|TELEGRAM_BOT_TOKEN|OPENCLAW_GATEWAY_TOKEN|sk-|xai-|AIza|:AA'

if rg -n "$PATTERN" \
  --glob '!**/.env' \
  --glob '!**/.env.*' \
  --glob '!**/.git/**' \
  --glob '!**/*.template' \
  .; then
  echo "FAIL: Potential secrets found."
  exit 1
fi

echo "No obvious secret patterns found."
