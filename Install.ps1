New-Item ..\Documents\WindowsPowerShell -ItemType Directory
New-Item -Value 'src\windows\profile.ps1' -Path '..\Documents\WindowsPowerShell' -Name 'profile.ps1' -ItemType SymbolicLink

New-Item -Value 'src\.ssh\config' -Path '..\.ssh' -Name 'config' -ItemType SymbolicLink
New-Item -Value '.\src\home\.gitconfig' -Path '..\' -Name '.gitconfig' -ItemType SymbolicLink
New-Item -Value '.\src\home\.vimrc' -Path '..\' -Name '.vimrc' -ItemType SymbolicLink

New-Item -Value 'src\vscode\settings.json' -Path '..\AppData\Roaming\Code\User' -Name 'settings.json' -ItemType SymbolicLink
New-Item -Value 'src\vscode\keybindings.json' -Path '..\AppData\Roaming\Code\User' -Name 'keybindings.json' -ItemType SymbolicLink

New-Item -Value 'src\.hyper.js' -Path '..\AppData\Roaming\Hyper' -Name '.hyper.js' -ItemType SymbolicLink

New-Item ..\AppData\Roaming\bat -ItemType Directory
New-Item -Value 'src\bat\config' -Path '..\AppData\Roaming\bat' -Name 'config' -ItemType SymbolicLink

# Windows Terminal config
New-Item ~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState -ItemType Directory
New-Item -Value 'src\Windows Terminal\settings.json' -Path '~\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState' -Name 'settings.json' -ItemType SymbolicLink
