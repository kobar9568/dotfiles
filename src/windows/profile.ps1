# 空cdでホームに
Remove-Item Alias:cd -Force
function cd() {
    if ($args.Length -gt 0) {
        Set-Location $args[0]
    } else {
        Set-Location $HOME
    }
}

# Linux風rm
Remove-Item Alias:rm -Force
function rm() {
    if ($args.Length -eq 0) {
        # 空打ち時
        Remove-Item
    } elseif ($args[0] -ceq "-rf") {
        # rm -rf
        Remove-Item -Recurse -Force $args[1]
    } else {
        # 普通のrm
        Remove-Item -Confirm $args[0]
    }
}

# Where-Objectへのエイリアスを削除し、where.exeが上がるようにする
Remove-Item Alias:where -Force

# 基本的にUTF-8しか使わない
Remove-Item Alias:cat -Force
function cat() {Get-Content -Encoding UTF8 $args}

# エイリアス
function ..() {Set-Location ../}
function ll() {Get-ChildItem}
function touch() {New-Item $args | Out-Null}
function mkdir() {New-Item -ItemType Directory $args | Out-Null}
function date() {(Get-Date -Format "o") -replace "\.[0-9]+"}
function stu() {git status}
function tig() {&$(Join-Path $(where.exe git | Split-Path -Parent | Split-Path -Parent) usr\bin\tig.exe)}

# hash系コマンドのエイリアス
function md5sum() {
    if ($args.Length -eq 0) {
        Write-Output "Alias from certutil to md5sum: No file is specified in the argument."
    } else {
        certutil -hashfile $args[0] md5
    }
}
function sha1sum() {
    if ($args.Length -eq 0) {
        Write-Output "Alias from certutil to sha1sum: No file is specified in the argument."
    } else {
        certutil -hashfile $args[0] sha1
    }
}
function sha256sum() {
    if ($args.Length -eq 0) {
        Write-Output "Alias from certutil to sha256sum: No file is specified in the argument."
    } else {
        certutil -hashfile $args[0] sha256
    }
}
function sha512sum() {
    if ($args.Length -eq 0) {
        Write-Output "Alias from certutil to sha512sum: No file is specified in the argument."
    } else {
        certutil -hashfile $args[0] sha512
    }
}

# よさみなの
function el() {explorer .}
function pwdc() {Set-Clipboard "$pwd"}

# プロンプトのカスタマイズ
function prompt() {
    Write-Host "$([char]27)[1m$env:USERNAME@$env:COMPUTERNAME" -ForegroundColor "Green" -NoNewline
    Write-Host ":" -ForegroundColor "White" -NoNewline
    Write-Host $pwd.ToString().Replace($env:HOMEDRIVE + $env:HOMEPATH, "~") -ForegroundColor "Blue" -NoNewline
    Write-Host "$" -ForegroundColor "White" -NoNewline
    return " "
}

# Activate vi mode.
Set-PSReadLineOption -EditMode vi # TODO: Mode indicator.

# Exit insert mode with jj.
Set-PSReadLineKeyHandler -Chord 'j' -ScriptBlock {
    if ([Microsoft.PowerShell.PSConsoleReadLine]::InViInsertMode()) {
        $key = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
        if ($key.Character -eq 'j') {
            [Microsoft.PowerShell.PSConsoleReadLine]::ViCommandMode()
        } else {
            [Microsoft.Powershell.PSConsoleReadLine]::Insert('j')
            [Microsoft.Powershell.PSConsoleReadLine]::Insert($key.Character)
        }
    }
}

# TODO: Exit shell with :q.
