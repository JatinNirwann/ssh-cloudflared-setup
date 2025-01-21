# Requires running with administrator privileges
#Requires -RunAsAdministrator

$ErrorActionPreference = "Stop"

function Write-Status {
    param($Message)
    Write-Host ">>> $Message" -ForegroundColor Green
}

try {
    # Define paths
    $cloudflaredPath = "C:\Windows\System32\cloudflared.exe"
    $sshConfigPath = "$env:USERPROFILE\.ssh\config"
    $tempDir = "$env:TEMP\cloudflared_setup"

    # Create temp directory if it doesn't exist
    if (!(Test-Path $tempDir)) {
        New-Item -ItemType Directory -Path $tempDir -Force | Out-Null
    }

    # Download cloudflared if not present
    if (!(Test-Path $cloudflaredPath)) {
        Write-Status "Downloading cloudflared..."
        $downloadUrl = "https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-windows-amd64.exe"
        $downloadPath = "$tempDir\cloudflared.exe"
        
        Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadPath
        
        Write-Status "Installing cloudflared to System32..."
        Copy-Item -Path $downloadPath -Destination $cloudflaredPath -Force
        
        # Clean up download
        Remove-Item -Path $downloadPath -Force
    }
    else {
        Write-Status "Cloudflared already installed."
    }

    # Create .ssh directory if it doesn't exist
    if (!(Test-Path "$env:USERPROFILE\.ssh")) {
        Write-Status "Creating .ssh directory..."
        New-Item -ItemType Directory -Path "$env:USERPROFILE\.ssh" | Out-Null
    }

    # SSH Configuration Content
    $configContent = @"
Host pissh.lelouchoncouch.in
    ProxyCommand C:\Windows\System32\cloudflared.exe access ssh --hostname %h
    User jatin
    StrictHostKeyChecking no
"@

    # Write SSH config
    Write-Status "Writing SSH configuration..."
    $configContent | Out-File -FilePath $sshConfigPath -Encoding UTF8 -Force

    # Clean up
    if (Test-Path $tempDir) {
        Remove-Item -Path $tempDir -Recurse -Force
    }

    Write-Status "Setup completed successfully!"
    Write-Host "SSH configuration has been written to: $sshConfigPath"
    Write-Host "Cloudflared has been installed to: $cloudflaredPath"
}
catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
    exit 1
}

# Keep window open if double-clicked
if ($Host.Name -eq "ConsoleHost") {
    Write-Host "`nPress any key to exit..."
    $null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
}
