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
    ][int]$Baud = 9600
)

$CloseKey = "[Ctrl + C]"

Write-Host "Open $Port with baud rate $Baud."
Write-Host "Press $CloseKey to close $Port."
Write-Host "----8<----[ cut here ]----------"

$COMPort = New-Object System.IO.Ports.SerialPort $Port, $Baud, ([System.IO.Ports.Parity]::None)

# Define COM port params.
$COMPort.DtrEnable = $true
$COMPort.RtsEnable = $true
$COMPort.Handshake = [System.IO.Ports.Handshake]::None
$COMPort.NewLine = "`r"
$COMPort.Encoding = [System.Text.Encoding]::GetEncoding("UTF-8")

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
        Write-Host ""
        Write-Host "----------[ cut here ]----8<----"
    Write-Host "Error: Cannot open $Port."
    exit
}

Try {
    while ($true) {
        if ([Console]::KeyAvailable) {
            $COMPort.Write(([Console]::ReadKey($true)).KeyChar)
        }
    }
}
Finally {
    Write-Host ""
    Write-Host "----------[ cut here ]----8<----"
    Write-Host "Closing $Port..."
    $COMPort.Close()
    Unregister-Event $d.Name
    Remove-Job $d.id
}
