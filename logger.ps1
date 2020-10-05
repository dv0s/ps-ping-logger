$hostToPing = Read-Host -Prompt 'Welke locatie wil je loggen?'
$logPathLocation = "$HOME\Desktop\ping-logger"
$logPath = "$HOME\Desktop\ping-logger\log-$hostToPing.txt"
$alwaysTrue = 1

if(!(Test-Path $logPathLocation)){
    New-Item -ItemType Directory -Force -Path $logPathLocation
}

while($alwaysTrue -eq "1")
{

        # refresh the timestamp before each ping attempt
        $theTime = Get-Date -format g

        # refresh the ping variable
        $result = ping $hostToPing -n 1

                if ($result -like '*reply*')
                {
                    Write-Output "$theTime - pass - connection to $hostToPing is up" | Out-File $logPath -append
                }
                else
                {
                    Write-Output "$theTime - fail - connection to $hostToPing is down" | Out-File $logPath -append
                }

        Start-Sleep 1
        Write-Output "Pinging $hostToPing"

}