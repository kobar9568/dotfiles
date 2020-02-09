New-Item -Value 'src\.ssh\config' -Path '..\.ssh' -Name 'config' -ItemType SymbolicLink
New-Item -Value '.\src\home\.gitconfig' -Path '..\' -Name '.gitconfig' -ItemType SymbolicLink
New-Item -Value '.\src\home\.vimrc' -Path '..\' -Name '.vimrc' -ItemType SymbolicLink

New-Item -Value 'src\vscode\settings.json' -Path '..\AppData\Roaming\Code\User' -Name 'settings.json' -ItemType SymbolicLink
New-Item -Value 'src\vscode\keybindings.json' -Path '..\AppData\Roaming\Code\User' -Name 'keybindings.json' -ItemType SymbolicLink

New-Item -Value 'src\.hyper.js' -Path '..\AppData\Roaming\Hyper' -Name '.hyper.js' -ItemType SymbolicLink
