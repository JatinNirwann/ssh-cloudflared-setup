# SSH Cloudflared Setup

This tool helps configure SSH access for a remote machine that you're accessing from outside your home network through a Cloudflared tunnel. It automatically sets up all the necessary components to enable secure remote SSH access to your machine through Cloudflare's infrastructure.

⚠️ **IMPORTANT**: Before running the script, you need to modify the following in `setup-ssh.ps1`:
- Change the host address (`ssh.lelouchoncouch.in`) to your server's domain
- Change the username (`jatin`) to your server's username

Automatically configures:
- Install cloudflared in System32
- Configure SSH for custom domain access
- Set up all necessary directories and permissions

## Quick Install

Run this command in PowerShell (as administrator):

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/JatinNirwann/ssh-cloudflared-setup/main/install.ps1'))
```

## Manual Installation

1. Clone this repository:
```powershell
git clone https://github.com/JatinNirwann/ssh-cloudflared-setup.git
```

2. Edit `setup-ssh.ps1` and update:
   ```powershell
   Host pissh.lelouchoncouch.in    # Change to your domain
       User jatin                   # Change to your username
   ```

3. Run the setup:
```powershell
cd ssh-cloudflared-setup
.\setup-ssh.bat
```

## Requirements
- Windows 10/11
- PowerShell 5.1 or higher
- Administrator privileges
- Existing Cloudflared tunnel configured on your remote machine

## What does this do?
1. Downloads and installs cloudflared to System32
2. Creates .ssh directory if it doesn't exist
3. Configures SSH for accessing your remote machine through Cloudflare tunnel
4. Sets up necessary proxy commands for external access
    
## Security
The script is open source - feel free to review the code before running it.
