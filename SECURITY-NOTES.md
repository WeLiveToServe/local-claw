# OpenClaw Security Notes (Sanitized)

## Core Rules

- Keep gateway bound to loopback (`127.0.0.1`) unless you intentionally deploy remote access.
- Keep Telegram in `dmPolicy: "pairing"` plus strict `allowFrom`.
- Keep file tools restricted (`workspaceOnly: true`).
- Keep secrets in `~/.openclaw/.env` and file perms at `600`.
- Treat all channels as untrusted input even from known users.

## Required Baseline Settings

- `gateway.bind: "loopback"`
- `gateway.auth.mode: "token"`
- `tools.exec.applyPatch.workspaceOnly: true`
- `tools.fs.workspaceOnly: true`
- `agents.defaults.sandbox.mode: "non-main"`
- `channels.telegram.dmPolicy: "pairing"`
- `channels.telegram.groupPolicy: "allowlist"`

## Security Checks (Run After Any Change)

1. `openclaw health`
2. `openclaw doctor`
3. `openclaw security audit --deep`
4. `systemctl --user status openclaw-gateway.service`
5. `ss -ltnp | rg 18789`

## Key Rotation Checklist

1. Rotate provider keys at source (provider console or BotFather).
2. Update `~/.openclaw/.env`.
3. Restart daemon: `systemctl --user restart openclaw-gateway.service`.
4. Verify with `openclaw health`.
5. Re-run deep audit.
6. Invalidate old backups containing pre-rotation secrets.

## Recovery Principle

This repo is documentation/templates/checks only. Keep live secrets and identity material off-repo.
