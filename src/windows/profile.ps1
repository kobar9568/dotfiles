# Set OutputEncoding.
$OutputEncoding = [console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

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
        $filePathList = $args[1..($args.Length - 1)]
        foreach($filePath in $filePathList) {
            Remove-Item -Recurse -Force $filePath
        }
    } else {
        # 普通のrm
        $filePathList = $args
        foreach($filePath in $filePathList) {
            Remove-Item -Confirm $filePath
        }
    }
}

# Where-Objectへのエイリアスを削除し、where.exeが上がるようにする
Remove-Item Alias:where -Force

# Invoke-WebRequestへのエイリアスを削除。
Remove-Item alias:curl
Remove-Item alias:wget

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

# Gitのリポジトリルートへcd
function cdg() {
    git rev-parse --show-superproject-working-tree --show-toplevel | Set-Location
}

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

# explorer.exeのエイリアス
function el() {
    if ($args.Length -gt 0) {
        explorer $args[0]
    } else {
        explorer .
    }
}
function pwdc() {Set-Clipboard "$pwd"}

# Source.mdの雛形生成
function src() {
    if (Test-Path .\Source.md) {
        Write-Output "src: .\Source.md already exists."
    } else {
        Write-Output "Generate Source.md in the current directory."
        "# Source`n`n## `n`n```````n`n```````n" | ForEach-Object { [Text.Encoding]::UTF8.GetBytes($_) } | Set-Content -Path ".\Source.md" -Encoding Byte
    }
}

# Cisco風にIPアドレス設定
function ip() {
    if ($args.Length -eq 4) {
        # ip addr {IP} {Subnet} {D/G}
        $SubnetOct = $args[2] -split "\."
        $intCIDR = 0
        for ($i = 0; $i -lt 4; $i++) {
            $intSubnetOct = $SubnetOct[$i]
            $strBitMask = [Convert]::ToString($intSubnetOct, 2)
            for ($j = 0; $j -lt 8; $j++) {
                if ($strBitMask[$j] -eq "1") {
                    $intCIDR++
                }
            }
        }
        $CIDR = [String]$intCIDR
        sudo netsh interface ip set address "Ethernet" static $args[1] $args[2] $args[3]
        #(sudo Get-NetAdapter -Name "Ethernet" | Remove-NetIPAddress -confirm:$false) -and (sudo Get-NetAdapter -Name "Ethernet" | Set-NetIPAddress -AddressFamily IPv4 -IPAddress $args[1] -PrefixLength $CIDR) -and (sudo Restart-NetAdapter -Name "Ethernet")
    } elseif ($args.Length -eq 2) {
        # ip addr dhcp
        sudo netsh interface ip set address "Ethernet" dhcp
    } else {
        Write-Output "ip: Invalid input."
    }
}

# Cisco風にshow
function show() {
    if ($args[0] -eq "ip") {
        Get-NetAdapter -Name "Ethernet" | Get-NetIPAddress | Where-Object {$_.AddressFamily -eq “IPv4”} | Select-Object IPAddress | foreach {$_.IPAddress}
    } elseif ($args[0] -eq "?") {
        Write-Host "  ip                 IP information"
    } else {
        Write-Host "% Type `"show ?`" for a list of subcommands"
    }
}

Set-Alias -Name sh -Value show

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

# Activate Starship.
$ENV:STARSHIP_CONFIG = "$HOME\dotfiles\src\starship\starship.toml"
Invoke-Expression (&starship init powershell)
