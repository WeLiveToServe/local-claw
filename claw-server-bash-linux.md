# claw-server-bash-linux

Use this when OpenClaw on the Linux server is unstable, browser tool fails, or the machine was hard-rebooted.

1. Enter terminal command:
```bash
OPENCLAW=/home/keith/.nvm/versions/node/v22.22.0/bin/openclaw
```
What it does: Sets the full path so commands work even if `openclaw` is not in `PATH`.

2. Enter terminal command:
```bash
$OPENCLAW gateway status
```
What it does: Confirms gateway service state, PID, and RPC health.

3. Enter terminal command:
```bash
$OPENCLAW browser status --browser-profile openclaw-chrome
```
What it does: Checks whether the dedicated Chrome profile is detected and running.

4. Enter terminal command:
```bash
$OPENCLAW browser --browser-profile openclaw-chrome start
```
What it does: Starts/restarts browser control for the OpenClaw profile.

5. Enter terminal command:
```bash
$OPENCLAW browser status --browser-profile openclaw-chrome
```
What it does: Verifies browser is now `running: true`.

6. If browser start times out, enter terminal command:
```bash
systemctl --user restart openclaw-gateway.service
sleep 8
$OPENCLAW browser --browser-profile openclaw-chrome start
$OPENCLAW browser status --browser-profile openclaw-chrome
```
What it does: Performs a clean gateway restart, then re-initializes browser control.

7. If failures continue, enter terminal command:
```bash
journalctl --user -u openclaw-gateway.service -n 120 --no-pager
```
What it does: Shows recent gateway errors (timeouts, CDP start failures, model/provider errors).

8. After a hard reboot/freeze, enter terminal command:
```bash
journalctl -b -1 -p 0..3 --no-pager | tail -n 200
journalctl -b -1 --no-pager | rg -i "oom|gpu|radeon|amdgpu|hang|lockup|panic|segfault" | tail -n 200
```
What it does: Pulls critical logs from the previous boot to identify crash signatures.

9. Optional quick smoke test prompt to assistant:
```text
Use browser tool. Open https://example.com and return only the page title.
```
What it does: Confirms tool routing is using browser control (not fallback web fetch).

