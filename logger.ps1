$hostToPing = Read-Host -Prompt 'Welke locatie wil je loggen?'
$logPathLocation = "$HOME\Desktop\ping-logger"
$initialDate = Get-Date -Format "yyyyMMdd"
$logPath = "$HOME\Desktop\ping-logger\log-$($initialDate)-$($hostToPing).txt"
$alwaysTrue = 1

if(!(Test-Path $logPathLocation)){
    New-Item -ItemType Directory -Force -Path $logPathLocation
}

while($alwaysTrue -eq "1")
{

    # Get actual date
    $currentDate = Get-Date -Format "yyyyMMdd"

    # Check previous date is the same as current date
    if ($initialDate -lt $currentDate) {

        # Set the variables according to current date
        Set-Variable initialDate -Value (Get-Date -Format "yyyyMMdd")
        Set-Variable logPath -Value "$HOME\Desktop\ping-logger\log-$($currentDate)-$($hostToPing).txt"
        
        # Check if file exists, if not, create one
        if (!(Test-Path $logPath)) {
            New-Item -ItemType File "log-$($currentDate)-$($hostToPing).txt"
        }
    }

    # refresh the timestamp before each ping attempt
    $theTime = Get-Date -Format "dd-MM-yyyy hh:mm:ss"

    # refresh the ping variable
    $result = ping $hostToPing -n 1

            if ($result -like '*reply*')
            {
                Write-Output "$theTime - pass - connection to $hostToPing is up" | Out-File $logPath -append
                Write-Output "$theTime - pass - connection to $hostToPing is up"
            }
            else
            {
                Write-Output "$theTime - fail - connection to $hostToPing is down" | Out-File $logPath -append
                Write-Output "$theTime - fail - connection to $hostToPing is down"
            }

    Start-Sleep 1

}