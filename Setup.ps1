# Setup script for Windots
# Author: Scott McKendry
 
#Requires -RunAsAdministrator

# Set working directory
Set-Location $PSScriptRoot

# Install dependencies - OMP, neovim, choco, mingw, ripgrep, fd, lazygit
if (!(Get-Command "oh-my-posh" -ErrorAction SilentlyContinue)) {
    winget install -e -h --id=JanDeDobbeleer.oh-my-posh 
}
if (!(Get-Command "nvim" -ErrorAction SilentlyContinue)) {
    winget install -e --id Neovim.Neovim
}
if (!(Get-Command "choco" -ErrorAction SilentlyContinue)) {
    winget install -e -h --id=Chocolatey.Chocolatey
}
if (!(Get-Command "gcc" -ErrorAction SilentlyContinue)) {
    choco install -y mingw
}
if (!(Get-Command "rg" -ErrorAction SilentlyContinue)) {
    choco install -y ripgrep
}
if (!(Get-Command "fd" -ErrorAction SilentlyContinue)) {
    choco install -y fd
}
if (!(Get-Command "lazygit" -ErrorAction SilentlyContinue)) {
    choco install -y lazygit
}

# Create Symbolic link to Profile.ps1 in PowerShell profile directory
New-Item -ItemType SymbolicLink -Path $PROFILE.CurrentUserAllHosts -Target (Resolve-Path .\Profile.ps1) -Force

# Create Symbolic link to Neovim Config
New-Item -ItemType SymbolicLink -Path $HOME\AppData\Local\nvim -Target (Resolve-Path .\nvim) -Force

# Install Terminal-Icons module
if (!(Get-Module -Name Terminal-Icons -ErrorAction SilentlyContinue)) {
    Install-Module -Name Terminal-Icons -Repository PSGallery
}

# Get all installed font families
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
$fontFamilies = (New-Object System.Drawing.Text.InstalledFontCollection).Families

# Check if CaskaydiaCove NF is installed
if ($fontFamilies -notcontains "JetBrainsMono NF") {
    # Download and install CaskaydiaCove NF
    $webClient = New-Object System.Net.WebClient
    $webClient.DownloadFile("https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip", ".\JetBrainsMono.zip")

    Expand-Archive -Path ".\JetBrainsMono.zip" -DestinationPath ".\JetBrainsMono" -Force
    $destination = (New-Object -ComObject Shell.Application).Namespace(0x14)
    Get-ChildItem -Path ".\JetBrainsMono" -Recurse -Filter "*.ttf" | ForEach-Object {
        If (-not(Test-Path "C:\Windows\Fonts\$($_.Name)")) {        
            # Install font
            $destination.CopyHere($_.FullName, 0x10)
        }
    }

    Remove-Item -Path ".\JetBrainsMono" -Recurse -Force
    Remove-Item -Path ".\JetBrainsMono.zip" -Force
}

# Import Windows Terminal settings
$terminalSettings = Get-Content -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" | ConvertFrom-Json -Depth 20

# Add font face property to terminalSettings object
$font = @{
  "face" = "JetBrainsMono Nerd Font"
  "size" = 10
}

Add-Member -InputObject $terminalSettings.profiles.defaults -MemberType NoteProperty -Name "font" -Value $font -Force

# Set Windows Terminal settings
$terminalSettings | ConvertTo-Json -Depth 20 | Set-Content -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" -Force
