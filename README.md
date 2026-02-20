# local-claw

Sanitized OpenClaw recovery repo for rebuilding a secure instance on a new machine.

## Purpose

- Keep only non-secret operational assets.
- Store repeatable install and hardening steps.
- Provide templates and checks for post-install validation.

## What Is Safe To Commit

- `brand-new-claw-install.md` install checklist.
- `SECURITY-NOTES.md` security runbook (sanitized).
- `templates/` config and systemd templates with placeholders only.
- `checks/` scripts for health, permissions, and secret scanning.
- `.env.example` variable names only.

## What Must Never Be Committed

- Real `.env` files, API keys, bot tokens, or gateway tokens.
- Real `openclaw.json` with live secrets.
- Device auth files (`~/.openclaw/identity/*`, `~/.openclaw/devices/*`).
- Chat/session logs containing private data.

## Quick Use

1. Follow `brand-new-claw-install.md` on the target machine.
2. Copy `templates/openclaw.json.template` to `~/.openclaw/openclaw.json` and fill placeholders.
3. Copy `.env.example` to `~/.openclaw/.env` and fill secrets locally.
4. Run:
   - `checks/check-perms.sh`
   - `checks/check-health.sh`
   - `checks/check-secrets.sh`
5. Create offline backup and verify checksum:
   - `tar -czf ~/openclaw-backup/openclaw-state-$(date +%Y%m%d-%H%M%S).tgz ~/.openclaw`
   - `sha256sum ~/openclaw-backup/openclaw-state-*.tgz`
6. Follow git hygiene:
   - Run `checks/check-secrets.sh` before commit.
   - Commit only templates/docs/scripts, never live state.
