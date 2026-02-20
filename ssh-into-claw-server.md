# ssh-into-claw-server

Use this to access the OpenClaw server from another trusted computer on your home network.

1. On the server, install SSH service:
```bash
sudo apt-get update
sudo apt-get install -y openssh-server
sudo systemctl enable --now ssh
sudo systemctl status ssh --no-pager
```
What it does: Installs and starts the SSH daemon.

2. On the server, get your LAN IP:
```bash
hostname -I
```
What it does: Shows local IP(s), e.g. `192.168.1.25`.

3. (Recommended) From your client machine, create an SSH key:
```bash
ssh-keygen -t ed25519 -a 100
```
What it does: Generates a strong keypair for passwordless login.

4. From your client machine, copy key to server:
```bash
ssh-copy-id keith@<SERVER_LAN_IP>
```
What it does: Installs your public key on the server for secure login.

5. From your client machine, log in:
```bash
ssh keith@<SERVER_LAN_IP>
```
What it does: Opens a remote shell on the server.

6. (Recommended) Restrict firewall to local network only:
```bash
sudo ufw allow from 192.168.1.0/24 to any port 22 proto tcp
sudo ufw enable
sudo ufw status
```
What it does: Allows SSH only from your home subnet.

7. (Recommended after key login works) harden SSH config:
```bash
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bak
sudo sed -i 's/^#\\?PermitRootLogin.*/PermitRootLogin no/' /etc/ssh/sshd_config
sudo sed -i 's/^#\\?PasswordAuthentication.*/PasswordAuthentication no/' /etc/ssh/sshd_config
sudo sshd -t && sudo systemctl restart ssh
```
What it does: Disables root/password login and keeps key-only access.

8. If you lock yourself out, use local keyboard on server and restore:
```bash
sudo cp /etc/ssh/sshd_config.bak /etc/ssh/sshd_config
sudo systemctl restart ssh
```
What it does: Reverts to prior SSH config.

9. OpenClaw checks after SSH login:
```bash
OPENCLAW=/home/keith/.nvm/versions/node/v22.22.0/bin/openclaw
$OPENCLAW gateway status
$OPENCLAW browser status --browser-profile openclaw-chrome
```
What it does: Verifies server-side OpenClaw and browser tool state.

