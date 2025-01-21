# SSH Cloudflared Setup

Automatically configure SSH with Cloudflared proxy for Windows systems. This script will:
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

2. Run the setup:
```powershell
cd ssh-cloudflared-setup
.\setup-ssh.bat
```

## Requirements
- Windows 10/11
- PowerShell 5.1 or higher
- Administrator privileges

## What does this do?
1. Downloads and installs cloudflared to System32
2. Creates .ssh directory if it doesn't exist
3. Configures SSH for your custom domain

## Security
The script is open source - feel free to review the code before running it.

## License
MIT License
