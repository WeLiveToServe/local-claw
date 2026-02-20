#!/usr/bin/env bash
set -euo pipefail

echo "Running OpenClaw health checks..."
openclaw health
echo
openclaw doctor
echo
openclaw security audit --deep
echo "Done."
