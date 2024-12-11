#Requires -RunAsAdministrator

# dotfiles in home directory
New-Item -Value "$PSScriptRoot\src\home\.gitconfig" -Path "~\" -Name ".gitconfig" -ItemType SymbolicLink
New-Item -Value "$PSScriptRoot\src\home\.vimrc" -Path "~\" -Name ".vimrc" -ItemType SymbolicLink
New-Item -Value "$PSScriptRoot\src\home\.markdownlintrc" -Path "~\" -Name ".markdownlintrc" -ItemType SymbolicLink
New-Item -Value "$PSScriptRoot\src\home\.nanorc" -Path "~\" -Name ".nanorc" -ItemType SymbolicLink

# PowerShell config
New-Item "~\Documents\WindowsPowerShell" -ItemType Directory
New-Item -Value "$PSScriptRoot\src\windows\profile.ps1" -Path "~\Documents\WindowsPowerShell" -Name "profile.ps1" -ItemType SymbolicLink
# For pwsh.exe
New-Item -Value "$Env:USERPROFILE\Documents\WindowsPowerShell\" -Path "~\Documents\" -Name "PowerShell\" -ItemType SymbolicLink

# SSH config
New-Item "~\.ssh\" -ItemType Directory # The folder has already been created in the process of cloning this script.
New-Item -Value "$PSScriptRoot\src\.ssh\config" -Path "~\.ssh" -Name "config" -ItemType SymbolicLink 

# Vim config
New-Item "~\vimfiles\" -ItemType Directory
New-Item -Value "$PSScriptRoot\src\vim\coc-settings.json" -Path "~\vimfiles" -Name "coc-settings.json" -ItemType SymbolicLink

# VSCode config
New-Item "~\AppData\Roaming\Code\User\" -ItemType Directory
New-Item -Value "$PSScriptRoot\src\vscode\settings.json" -Path "~\AppData\Roaming\Code\User" -Name "settings.json" -ItemType SymbolicLink
New-Item -Value "$PSScriptRoot\src\vscode\keybindings.json" -Path "~\AppData\Roaming\Code\User" -Name "keybindings.json" -ItemType SymbolicLink

# Hyper config
New-Item "~\AppData\Roaming\Hyper\" -ItemType Directory
New-Item -Value "$PSScriptRoot\src\.hyper.js" -Path "~\AppData\Roaming\Hyper" -Name ".hyper.js" -ItemType SymbolicLink

# bat config
New-Item "~\AppData\Roaming\bat" -ItemType Directory
New-Item -Value "$PSScriptRoot\src\bat\config" -Path "~\AppData\Roaming\bat" -Name "config" -ItemType SymbolicLink

# Windows Terminal config
New-Item "~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -ItemType Directory # If you have installed the application, this folder probably already exists.
New-Item -Value "$PSScriptRoot\src\Windows Terminal\settings.json" -Path "~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -Name "settings.json" -ItemType SymbolicLink

# Tera Term config
New-Item -Value "$PSScriptRoot\src\Tera Term\TERATERM.INI" -Path "~\Documents" -Name "TERATERM.INI" -ItemType SymbolicLink

# neofetch config
New-Item "~\.config\neofetch\" -ItemType Directory
New-Item -Value "$PSScriptRoot\src\neofetch\config.conf" -Path "~\.config\neofetch\" -Name "config.conf" -ItemType SymbolicLink

# Alacritty config
New-Item "~\AppData\alacritty\" -ItemType Directory
New-Item -Value "$PSScriptRoot\src\alacritty\alacritty.yml" -Path "~\AppData\alacritty\" -Name "alacritty.yml" -ItemType SymbolicLink

# Parsec config
New-Item "~\AppData\Roaming\Parsec\" -ItemType Directory
New-Item -Value "$PSScriptRoot\src\Parsec\config.txt" -Path "~\AppData\Roaming\Parsec\" -Name "config.txt" -ItemType SymbolicLink

# TVTest config
New-Item "C:\Portable Program\TVTest-0.9.0-x64\" -ItemType Directory
New-Item -Value "$PSScriptRoot\src\TVTest\BonDriver_Mirakurun.ini" -Path "C:\Portable Program\TVTest-0.9.0-x64\" -Name "BonDriver_Mirakurun.ini" -ItemType SymbolicLink

# Set Environment variables.

# Python encoding
# Omit "python -x utf8 .\main.py > output.txt".
[Environment]::SetEnvironmentVariable("PYTHONUTF8", "1", "Machine")

# Java encoding
[Environment]::SetEnvironmentVariable("JAVA_TOOL_OPTIONS", "-Dfile.encoding=UTF8", "Machine")

# Update PSReadLine
Install-Module -Name PSReadLine -Force # TODO: Handle repository trust warnings

# Setup Scoop command.
# The Scoop command basically runs with user privileges, but here we will use it as a system-wide package manager.
#
# Install Scoop command in system-wide.
$ScoopRootDir = "C:\Scoop\"
mkdir $ScoopRootDir
$Env:SCOOP = $ScoopRootDir
[Environment]::SetEnvironmentVariable("SCOOP", $Env:SCOOP, "Machine")
Invoke-Expression (New-Object System.Net.WebClient).DownloadString("https://get.scoop.sh")

# Change the PATH.
$Env:SCOOP_COMMAND_PATH = $Env:SCOOP + "shims\"

$SystemPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
$SystemPath += ";" + $Env:SCOOP_COMMAND_PATH
[Environment]::SetEnvironmentVariable('Path', $SystemPath, 'Machine')

$UserPath = [Environment]::GetEnvironmentVariable("Path", "User")
$UserPath = ($UserPath.Split(';') | Where-Object { $_ -ne $Env:SCOOP_COMMAND_PATH }) -join ';'
[Environment]::SetEnvironmentVariable("Path", $UserPath, "User")

# Set Scoop global install target.
$Env:SCOOP_GLOBAL = $ScoopRootDir
[Environment]::SetEnvironmentVariable("SCOOP_GLOBAL", $env:SCOOP, "Machine")

# Install fixed version of OpenSSH Client.
# For more information, see here.
# https://kobar9568.hatenablog.com/entry/2020/09/08/205736
if (![System.Environment]::GetEnvironmentVariable("Path", "Machine").Contains("C:\Portable Program\OpenSSH-Win64")) {
    Invoke-WebRequest "https://github.com/PowerShell/Win32-OpenSSH/releases/download/v8.1.0.0p1-Beta/OpenSSH-Win64.zip" -OutFile "$HOME\Downloads\OpenSSH-Win64.zip"
    Expand-Archive "$HOME\Downloads\OpenSSH-Win64.zip" -DestinationPath "C:\Portable Program\"
    Remove-Item "$HOME\Downloads\OpenSSH-Win64.zip"
    $oldSystemPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
    $oldSystemPath += ";C:\Portable Program\OpenSSH-Win64"
    [System.Environment]::SetEnvironmentVariable("Path", $oldSystemPath, "Machine")
    dism /Online /Remove-Capability /CapabilityName:OpenSSH.Client~~~~0.0.1.0
}

# Add yarn global add PATH.
$SystemPath = [Environment]::GetEnvironmentVariable("Path", "Machine")
$SystemPath += ";" + (yarn global bin) + "\" # TODO: If the yarn is not installed, it will fail.
[Environment]::SetEnvironmentVariable('Path', $SystemPath, 'Machine')

# Install bat command.
if (![System.Environment]::GetEnvironmentVariable("Path", "Machine").Contains("C:\Portable Program\bat-v0.17.1-x86_64-pc-windows-msvc")) {
    Invoke-WebRequest "https://github.com/sharkdp/bat/releases/download/v0.17.1/bat-v0.17.1-x86_64-pc-windows-msvc.zip" -OutFile "$HOME\Downloads\bat-v0.17.1-x86_64-pc-windows-msvc.zip"
    Expand-Archive "$HOME\Downloads\bat-v0.17.1-x86_64-pc-windows-msvc.zip" -DestinationPath "C:\Portable Program\"
    Remove-Item "$HOME\Downloads\bat-v0.17.1-x86_64-pc-windows-msvc.zip"
    $oldSystemPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
    $oldSystemPath += ";C:\Portable Program\bat-v0.17.1-x86_64-pc-windows-msvc"
    [System.Environment]::SetEnvironmentVariable("Path", $oldSystemPath, "Machine")
}
