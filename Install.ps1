#Requires -RunAsAdministrator

New-Item ..\Documents\WindowsPowerShell -ItemType Directory
New-Item -Value 'src\windows\profile.ps1' -Path '..\Documents\WindowsPowerShell' -Name 'profile.ps1' -ItemType SymbolicLink

New-Item -Value 'src\.ssh\config' -Path '..\.ssh' -Name 'config' -ItemType SymbolicLink
New-Item -Value '.\src\home\.gitconfig' -Path '..\' -Name '.gitconfig' -ItemType SymbolicLink
New-Item -Value '.\src\home\.vimrc' -Path '..\' -Name '.vimrc' -ItemType SymbolicLink
New-Item -Value '.\src\home\.markdownlintrc' -Path '..\' -Name '.markdownlintrc' -ItemType SymbolicLink

New-Item -Value 'src\vscode\settings.json' -Path '..\AppData\Roaming\Code\User' -Name 'settings.json' -ItemType SymbolicLink
New-Item -Value 'src\vscode\keybindings.json' -Path '..\AppData\Roaming\Code\User' -Name 'keybindings.json' -ItemType SymbolicLink

New-Item -Value 'src\.hyper.js' -Path '..\AppData\Roaming\Hyper' -Name '.hyper.js' -ItemType SymbolicLink

New-Item ..\AppData\Roaming\bat -ItemType Directory
New-Item -Value 'src\bat\config' -Path '..\AppData\Roaming\bat' -Name 'config' -ItemType SymbolicLink

# Windows Terminal config
New-Item ~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState -ItemType Directory
New-Item -Value 'src\Windows Terminal\settings.json' -Path '~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState' -Name 'settings.json' -ItemType SymbolicLink

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

# Install bat command.
if (![System.Environment]::GetEnvironmentVariable("Path", "Machine").Contains("C:\Portable Program\bat-v0.17.1-x86_64-pc-windows-msvc")) {
    Invoke-WebRequest "https://github.com/sharkdp/bat/releases/download/v0.17.1/bat-v0.17.1-x86_64-pc-windows-msvc.zip" -OutFile "$HOME\Downloads\bat-v0.17.1-x86_64-pc-windows-msvc.zip"
    Expand-Archive "$HOME\Downloads\bat-v0.17.1-x86_64-pc-windows-msvc.zip" -DestinationPath "C:\Portable Program\"
    Remove-Item "$HOME\Downloads\bat-v0.17.1-x86_64-pc-windows-msvc.zip"
    $oldSystemPath = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
    $oldSystemPath += ";C:\Portable Program\bat-v0.17.1-x86_64-pc-windows-msvc"
    [System.Environment]::SetEnvironmentVariable("Path", $oldSystemPath, "Machine")
}
