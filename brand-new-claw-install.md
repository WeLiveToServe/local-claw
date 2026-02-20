# brand-new-claw-install.md

1. Enter terminal command: `sudo apt-get update && sudo apt-get install -y curl git jq ripgrep`
   Enter exact Codex prompt: `"Confirm dependencies are installed and list any missing packages."`
   What this does: Installs the minimum OS tools needed for repeatable setup and verification.

2. Enter terminal command: `curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash - && sudo apt-get install -y nodejs`
   Enter exact Codex prompt: `"Verify system Node install from /usr/bin and confirm version is 22 or higher."`
   What this does: Installs a stable system-managed Node runtime for daemon reliability.

3. Enter terminal command: `sudo npm install -g openclaw && openclaw --version`
   Enter exact Codex prompt: `"Confirm OpenClaw CLI is installed and report version."`
   What this does: Installs OpenClaw globally and verifies CLI availability.

4. Enter terminal command: `mkdir -p ~/.openclaw && chmod 700 ~/.openclaw && touch ~/.openclaw/.env && chmod 600 ~/.openclaw/.env`
   Enter exact Codex prompt: `"Confirm ~/.openclaw exists with secure permissions and no world access."`
   What this does: Creates the secure state directory and protects secret file access.

5. Enter terminal command: `cat > ~/.openclaw/.env`
   Enter exact Codex prompt: `"Wait for me to paste .env values, then validate required variables exist without printing secret values."`
   What this does: Creates local secret material without storing it in code repositories.

6. Enter terminal command: `cat > ~/.openclaw/openclaw.json`
   Enter exact Codex prompt: `"Wait for me to paste sanitized openclaw.json content, then validate JSON schema basics and security-critical fields."`
   What this does: Writes main config with hardening defaults and channel policy controls.

7. Enter terminal command: `chmod 600 ~/.openclaw/openclaw.json`
   Enter exact Codex prompt: `"Check file permissions for ~/.openclaw, ~/.openclaw/.env, and ~/.openclaw/openclaw.json."`
   What this does: Enforces strict permissions on sensitive runtime config.

8. Enter terminal command: `openclaw gateway install`
   Enter exact Codex prompt: `"Verify service installation and show the exact unit path and runtime command."`
   What this does: Installs persistent daemon service managed by the OS.

9. Enter terminal command: `systemctl --user daemon-reload && systemctl --user enable openclaw-gateway.service && systemctl --user start openclaw-gateway.service`
   Enter exact Codex prompt: `"Verify service is enabled and active, then print only the top status lines."`
   What this does: Starts the daemon and ensures it survives normal restarts.

10. Enter terminal command: `ss -ltnp | rg 18789`
    Enter exact Codex prompt: `"Confirm gateway is listening only on loopback and identify owning PID."`
    What this does: Confirms local-only exposure and single-process ownership.

11. Enter terminal command: `openclaw health`
    Enter exact Codex prompt: `"Validate health output and identify failed subsystems without exposing secrets."`
    What this does: Performs functional availability check across gateway and channels.

12. Enter terminal command: `openclaw doctor`
    Enter exact Codex prompt: `"Review doctor output and classify findings as critical, fix-now, or acceptable-risk."`
    What this does: Performs structured platform checks and highlights drift.

13. Enter terminal command: `openclaw security audit --deep`
    Enter exact Codex prompt: `"Review deep audit and list only actionable warnings with one-line remediations."`
    What this does: Performs security control checks for exposure, auth, and model risk.

14. Enter terminal command: `test -f ~/.config/systemd/user/openclaw-gateway.service && sed -n '1,80p' ~/.config/systemd/user/openclaw-gateway.service`
    Enter exact Codex prompt: `"Check service file for embedded secrets and confirm EnvironmentFile usage for .env when supported."`
    What this does: Detects secret sprawl in service definition.

15. Enter terminal command: `openclaw config get gateway.bind && openclaw config get channels.telegram.dmPolicy && openclaw config get tools.fs.workspaceOnly`
    Enter exact Codex prompt: `"Confirm bind=loopback, dmPolicy=pairing, and workspaceOnly=true values are active."`
    What this does: Verifies non-negotiable hardening settings are actually live.

16. Enter terminal command: `openclaw config get channels.telegram.allowFrom`
    Enter exact Codex prompt: `"Verify allowFrom is a strict whitelist and not wildcard/open."`
    What this does: Ensures only approved Telegram identities can control the bot.

17. Enter terminal command: `mkdir -p ~/openclaw-backup && tar -czf ~/openclaw-backup/openclaw-state-$(date +%Y%m%d-%H%M%S).tgz ~/.openclaw`
    Enter exact Codex prompt: `"Confirm backup archive exists and remind me to store it encrypted off-machine."`
    What this does: Creates disaster-recovery snapshot of local OpenClaw state.

18. Enter terminal command: `echo "STOP: run key-rotation drill + restore drill before production use."`
    Enter exact Codex prompt: `"Generate a short checklist for quarterly key rotation, service restart verification, and restore testing."`
    What this does: Establishes ongoing security hygiene beyond initial setup.
