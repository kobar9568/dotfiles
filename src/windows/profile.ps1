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

# Compare-Objectへのエイリアスを削除し、scoopで入れたdiff.exeが上がるようにする
Remove-Item Alias:diff -Force

# 基本的にUTF-8しか使わない
Remove-Item Alias:cat -Force
function cat() {Get-Content -Encoding UTF8 $args}

# セッション単位ではないhistory
Remove-Item Alias:history -Force
function history() {
    (Get-Content -Encoding UTF8 (Get-PSReadlineOption).HistorySavePath)[(Get-Content -Encoding UTF8 (Get-PSReadlineOption).HistorySavePath).length..0] | less
}

# エイリアス
function ..() {Set-Location ../}
function ll() {Get-ChildItem}
function touch() {New-Item $args | Out-Null}
function mkdir() {New-Item -ItemType Directory $args | Out-Null}
function date() {(Get-Date -Format "o") -replace "\.[0-9]+"}
function stu() {git status}
function tig() {&$(Join-Path $(where.exe git | Split-Path -Parent | Split-Path -Parent) usr\bin\tig.exe)}
function :q() {exit}
function :q!() {exit}
function tac() {(Get-Content -Encoding UTF8 $args)[(Get-Content -Encoding UTF8 $args).length..0]}

# Gitのリポジトリルートへcd
function cdg() {
    git rev-parse --show-superproject-working-tree --show-toplevel | Set-Location
}

# cuコマンド
function cu() {
    Param([ValidateSet("COM1", "COM2", "COM3", "COM4", "COM5", "COM6")][String]$Port = "COM3", [ValidateSet("110", "300", "600", "1200", "2400", "4800", "9600", "14400", "19200", "38400", "57600", "115200", "128000", "256000")][int]$Baud = 9600)
    .$HOME\dotfiles\src\windows\Scripts\Serial.ps1 $Port $Baud
}

# unameコマンド
function uname() {
    $ver = (cmd.exe /C ver)
    if ($args.Length -eq 0) {
        Write-Output $ver.split("")[2]
    } elseif ($args -ceq "-o") {
        Write-Output ($ver.split("")[1] + " " + $ver.split("")[2])
    } elseif ($args -ceq "-a") {
        Write-Output $ver
    }
}

# printenvコマンド
function printenv() {
    $envs_str = ""
    Get-ChildItem Env: | ForEach-Object {
        [String]::Concat($envs_str, ($_.Name + "=" + $_.Value))
    }
    Write-Host -NoNewline $envs_str
}

# exportコマンド
function export(){
    if ($args.Length -eq 1) {
        $name = ($args | Out-String -Stream).split("=")[0]
        $value = ($args | Out-String -Stream).split("=")[1]
        [Environment]::SetEnvironmentVariable($name, $value, "User")
    } elseif (($args.Length -eq 2) -And ($args[0] -ceq "-n")) {
        $name = $args[1]
        [Environment]::SetEnvironmentVariable($name, $null, "User")
    } else {
        Write-Output "export: error."
    }
}

# fc-list command for Windows.
function fc-list() {
    [void][reflection.assembly]::LoadWithPartialName("System.Drawing")
    $families = [System.Drawing.FontFamily]::Families

    $families_str = ""
    $families | ForEach-Object {
        [String]::Concat($families_str, ($_.Name))
    }
    Write-Host -NoNewline $families_str
}

# Symlink
function ln() {
    if ($args.Length -eq 0) {
        # 空打ち時
        Write-Output "ln: missing file operand"
    } elseif ($args[0] -ceq "-s") {
        # ln -s
        if ($args.Length -eq 2) {
            cmd.exe /C mklink $args[2] $args[1]
        } elseif ($args.Length -eq 1) {
            # Todo: リンク名を省略したパターン
        }
    } else {
        # ハードリンク作成
        cmd.exe /C mklink /h $args[1] $args[0]
        Write-Output "ln: Created Hard link."
    }
}

function unlink() {
    Remove-Item -Force $args
}

# Wiresharkの為にTLSのマスターシークレットを出力する
function debugtls() {
    $master_secret_path = "$Env:USERPROFILE\tls.keys"
    if ($args[0] -eq "enable" -Or $args[0] -eq "en") {
        export SSLKEYLOGFILE=$master_secret_path
    } elseif ($args[0] -eq "disable" -Or $args[0] -eq "dis") {
        export -n SSLKEYLOGFILE
    } elseif ($args[0] -eq "delete" -Or $args[0] -eq "del") {
        Remove-Item -Confirm $master_secret_path
    } elseif ($args[0] -eq "status" -Or $args[0] -eq "stat") {

        if ([Environment]::GetEnvironmentVariable("SSLKEYLOGFILE", "User") -eq $null) {
            Write-Host -NoNewline "Master Secret output: "; Write-Host -NoNewline -ForegroundColor Red "disabled"; Write-Host "."
        } else {
            Write-Host -NoNewline "Master Secret output: "; Write-Host -NoNewline -ForegroundColor Green "enabled"; Write-Host "."
        }

        Write-Host

        if (Test-Path $master_secret_path) {
            Write-Host "Master Secret exists."
            Write-Host $master_secret_path
        } else {
            Write-Host "Master Secret does not exists."
        }

    } else {
        Write-Host "usage: debugtls`r`n   debugtls enable  : Enable Master Secret output.`r`n   debugtls disable : Disable Master Secret output.`r`n   debugtls delete  : Delete Master Secret file.`r`n   debugtls status  : Display output status of master secret."
    }
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

# クリップボードにカレントディレクトリのパスをコピー
function pwdc() {Set-Clipboard "$pwd"}

# ghq createをOSユーザ名ではなくGitHubのユーザ名で実行する
$ghq = where.exe ghq
function ghq() {
    if ($args[0] -ceq "create") {
        # ghq create
        $ghq_username = "kobar9568"
        $os_username = [Environment]::GetEnvironmentVariable("USERNAME", "Process")
        [Environment]::SetEnvironmentVariable("USERNAME", $ghq_username, "Process")
        .$ghq create $args[1]
        [Environment]::SetEnvironmentVariable("USERNAME", $os_username, "Process")
    } else {
        # その他ghq実行時
        .$ghq $args[0] $args[1]
    }
}

# フォントテスト
function rand() {
    Write-Output "The quick brown fox jumps over the lazy dog. 1234567890"
}

# Source.mdの雛形生成
function src() {
    if (Test-Path .\Source.md) {
        Write-Output "src: .\Source.md already exists."
    } else {
        Write-Output "Generate Source.md in the current directory."
        "# Source`n`n## `n`n```````n`n```````n" | ForEach-Object { [Text.Encoding]::UTF8.GetBytes($_) } | Set-Content -Path ".\Source.md" -Encoding Byte
    }
}

# Windows Defender Firewallの切り替え
function wfw() {
    if ($args[0] -eq "enable" -Or $args[0] -eq "en") {
        sudo Set-NetFirewallProfile -Enabled true
    } elseif ($args[0] -eq "disable" -Or $args[0] -eq "dis") {
        sudo Set-NetFirewallProfile -Enabled false
    } elseif ($args[0] -eq "status" -Or $args[0] -eq "stat") {
        Get-NetFirewallProfile
    } else {
        Write-Host "usage: wfw`r`n   wfw enable: Activate all profiles of Windows Defender Firewall.`r`n   wfw disable: Deactivate all profiles of Windows Defender Firewall.`r`n   wfw status: Display status of Windows Defender Firewall."
    }
}

# Wi-Fiへ接続
function conap() {
    if ($args[0] -eq "status" -Or $args[0] -eq "stat") {
        # Todo: Check netsh syntax
        netsh wlan show networks
    } elseif ($args.Length -eq 1) {
        $ssid = $args[0]
        $name = $args[0]
        netsh wlan connect ssid=$ssid name=$name
    } elseif ($args.Length -eq 2) {
        # Todo: Check netsh syntax
        $ssid = $args[0]
        $key = $args[1]
        netsh wlan connect ssid=$ssid key=$key
    } else {
        Write-Host "usage: conap`r`n   conap <SSID or ESSID>                 : Connect to a known (E)SSID.`r`n   conap <SSID or ESSID> <Pre-shared key>: Connect to a (E)SSID.`r`n   conap status                          : Show current Wi-Fi connectivity."
    }
}

# ディスプレイへの映像出力無効化
function dpsleep() {
    if ($args[0] -eq "enable" -Or $args[0] -eq "en") {
        [void][Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
        $form=new-object System.Windows.Forms.Form
        $message=[System.Windows.Forms.Message]::Create($form.Handle,274,61808,2)
        $nativeWindow=new-object System.Windows.Forms.NativeWindow
        $nativeWindow.DefWndProc([ref]$message)
    } elseif ($args[0] -eq "disable" -Or $args[0] -eq "dis") {
        [void][Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
        $form=new-object System.Windows.Forms.Form
        $message=[System.Windows.Forms.Message]::Create($form.Handle,274,61808,-1)
        $nativeWindow=new-object System.Windows.Forms.NativeWindow
        $nativeWindow.DefWndProc([ref]$message)
    } else {
        Write-Host "usage: dpsleep`r`n   dpsleep enable: Set the display to sleep mode.`r`n   dpsleep disable: Restore the display from sleep mode."
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
        $IP = Get-NetAdapter -Name "Ethernet" | Get-NetIPAddress | Where-Object {$_.AddressFamily -eq “IPv4”} | Select-Object IPAddress | foreach {$_.IPAddress}
        Write-Host "Interface                  IP-Address      OK? Method Status                Protocol"
        Write-Host "GigabitEthernet            $IP       YES DHCP   up                    up"
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

# Workaround for Shift + Backspace issue.
Set-PSReadLineKeyHandler -Chord 'Shift+BackSpace' -Function BackwardDeleteChar

# Ctrl + G to open the ghq repository list.
Set-PSReadLineKeyHandler -Chord 'Ctrl+g' -ScriptBlock {
    Write-Host "^G"
    $before_dir = $pwd

    $after_dir = (ghq root) + "/" + (ghq list | fzf --preview "bat --color=always --style=header,grid --line-range :80 $(ghq root)/{}/README.*")

    # Esc to cancel.
    if ($after_dir -ne (ghq root) + "/") {
        Set-Location $after_dir
    }

    # TODO: Not working.
    if ($before_dir -ne $pwd) {
        Get-ChildItem
    }
}

# TODO: Exit shell with :q.

# Activate Starship.
$ENV:STARSHIP_CONFIG = "$HOME\dotfiles\src\starship\starship.toml"
Invoke-Expression (&starship init powershell)
