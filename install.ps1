# install.ps1
$ErrorActionPreference = "Stop"

function Write-Status {
    param($Message)
    Write-Host ">>> $Message" -ForegroundColor Green
}

try {
    # Create temporary directory
    $tempDir = "$env:TEMP\ssh-cloudflared-setup"
    New-Item -ItemType Directory -Force -Path $tempDir | Out-Null

    Write-Status "Downloading setup files..."
    
    # Download required files from GitHub
    $files = @{
        "setup-ssh.ps1" = "https://raw.githubusercontent.com/JatinNirwann/ssh-cloudflared-setup/main/setup-ssh.ps1"
        "setup-ssh.bat" = "https://raw.githubusercontent.com/JatinNirwann/ssh-cloudflared-setup/main/setup-ssh.bat"
    }

    foreach ($file in $files.GetEnumerator()) {
        $downloadPath = Join-Path $tempDir $file.Key
        Invoke-WebRequest -Uri $file.Value -OutFile $downloadPath
    }

    Write-Status "Starting installation..."
    
    # Execute the batch file
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c", "$tempDir\setup-ssh.bat" -Wait
    
    Write-Status "Cleaning up..."
    
    # Clean up temporary files
    Remove-Item -Path $tempDir -Recurse -Force
    
    Write-Status "Installation completed!"
}
catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
    if (Test-Path $tempDir) {
        Remove-Item -Path $tempDir -Recurse -Force
    }
    exit 1
}
