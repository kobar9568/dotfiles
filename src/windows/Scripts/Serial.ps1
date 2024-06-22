# Serial.ps1
# Based on:
# https://qiita.com/yapg57kon/items/58d7f47022b3e405b5f3
# https://qiita.com/mori-oh/items/9254fde34203fb1db9af

Param (
    [
        ValidateSet (
            "COM1",
            "COM2",
            "COM3",
            "COM4",
            "COM5",
            "COM6",
            "COM7",
            "COM8",
            "COM9",
            "COM10",
            "COM11",
            "COM12",
            "COM13",
            "COM14",
            "COM15",
            "COM16"
        )
    ][String]$Port = "COM3",
    [
        ValidateSet (
            "110",
            "300",
            "600",
            "1200",
            "2400",
            "4800",
            "9600",
            "14400",
            "19200",
            "38400",
            "57600",
            "115200",
            "128000",
            "256000"
        )
    ][int]$Baud = 9600,
    [
        ValidateSet (
            "UTF-8",
            "Shift-JIS"
        )
    ][String]$Lang = "UTF-8",
    [switch]$FlushesConsole
)

[char]$ETX = 0x03
[char]$LF  = 0x09
[char]$CR  = 0x0a
[char]$NAK = 0x15
[char]$ESC = 0x1b
[char]$DEL = 0x7F

function InputKeyParser([System.ConsoleKeyInfo]$key) {
    if ($key.Modifiers -eq 'Ctrl' -and $key.Key -eq 'C') {
        $return = $ETX
    }
    elseif ($key.Key -eq 'UpArrow')    { $return = "${ESC}[A" }
    elseif ($key.Key -eq 'DownArrow')  { $return = "${ESC}[B" }
    elseif ($key.Key -eq 'RightArrow') { $return = "${ESC}[C" }
    elseif ($key.Key -eq 'LeftArrow')  { $return = "${ESC}[D" }
    elseif ($key.Key -eq 'Home')       { $return = "${ESC}[H" }
    elseif ($key.Key -eq 'End')        { $return = "${ESC}[F" }
    elseif ($key.Key -eq 'Insert')     { $return = "${ESC}[2~" }
    elseif ($key.Key -eq 'Delete')     { $return = "${ESC}[3~" }
    elseif ($key.Key -eq 'PageUp')     { $return = "${ESC}[5~" }
    elseif ($key.Key -eq 'PageDown')   { $return = "${ESC}[6~" }
    else {
        $return = $key.KeyChar
    }
    return $return
}

$CloseKey = "[Ctrl + Alt + C]"
Write-Host "Open $Port with baud rate $Baud."
Write-Host "Character code: $Lang"
Write-Host "Press $CloseKey to close $Port."
Write-Host "----8<----[ cut here ]----------"

if ($FlushesConsole) {
    clear
}

$COMPort = New-Object System.IO.Ports.SerialPort $Port, $Baud, ([System.IO.Ports.Parity]::None)

# Define COM port params.
$COMPort.DtrEnable = $true
$COMPort.RtsEnable = $true
$COMPort.Handshake = [System.IO.Ports.Handshake]::None
$COMPort.NewLine = "`r"
$COMPort.Encoding = [System.Text.Encoding]::GetEncoding($Lang)

# Disable Ctrl + C
[Console]::TreatControlCAsInput = $true

$d = Register-ObjectEvent -InputObject $COMPort -EventName "DataReceived" `
    -Action {
        Param (
            [System.IO.Ports.SerialPort]$sender, [System.EventArgs]$e
        )
        Write-Host -NoNewline $sender.ReadExisting()
    }

Try {
    $COMPort.Open()
}
Catch {
    if (!$FlushesConsole) {
        Write-Host ""
        Write-Host "----------[ cut here ]----8<----"
    }
    Write-Host "Error: Cannot open $Port."
    exit
}

Try {
    while ($true) {
        if ([Console]::KeyAvailable) {
            $keyInput = [Console]::ReadKey($true)
            if ($keyInput.Modifiers -eq "Alt, Control" -and $keyInput.Key -eq "C") {
                break
            }
            $sendChar = InputKeyParser($keyInput)
            $COMPort.Write($sendChar)
        }
    }
}
Finally {
    if (!$FlushesConsole) {
        Write-Host ""
        Write-Host "----------[ cut here ]----8<----"
        Write-Host "Closing $Port..."
    }
    $COMPort.Close()
    Unregister-Event $d.Name
    Remove-Job $d.id
}
