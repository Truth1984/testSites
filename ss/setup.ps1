# $env:full=1; Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.gitmirror.com/Truth1984/testSites/master/ss/setup.ps1'))

echo SCRIPT_VERSION=1.0.2

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# install git

choco install -y git curl

Set-Location "C:\Program Files\Git"

# init u2

bash -c 'preurl="https://raw.gitmirror.com/Truth1984/testSites/master/ss/setup.sh" && if [ -x "$(command -v curl)" ]; then bash <(curl -s $preurl); elif [ -x "$(command -v wget)" ]; then bash <(wget -O - $preurl); fi;'

# remove preinstalled app
$AppPackageNames = @("Microsoft.3DBuilder","Microsoft.BingFinance","Microsoft.BingNews","Microsoft.BingSports","Microsoft.BingWeather","Microsoft.GetHelp","Microsoft.Getstarted","Microsoft.Messaging","Microsoft.Microsoft3DViewer","Microsoft.MicrosoftOfficeHub","Microsoft.MicrosoftSolitaireCollection",
"Microsoft.MinecraftUWP","Microsoft.NetworkSpeedTest","Microsoft.Office.OneNote","Microsoft.OneConnect","Microsoft.People","Microsoft.Print3D","Microsoft.SkypeApp","Microsoft.StorePurchaseApp","Microsoft.Wallet","Microsoft.WindowsAlarms","Microsoft.WindowsCalculator","Microsoft.WindowsCamera",
"Microsoft.WindowsMaps","Microsoft.WindowsPhone","Microsoft.WindowsSoundRecorder","Microsoft.Xbox.TCUI","Microsoft.XboxApp","Microsoft.XboxGameOverlay","Microsoft.XboxIdentityProvider","Microsoft.XboxSpeechToTextOverlay","Microsoft.ZuneMusic","Microsoft.ZuneVideo");
ForEach ($AppPackageName in $AppPackageNames) {Write-Host "Removing $AppPackageName...";Get-AppxPackage -Name $AppPackageName -AllUsers | Remove-AppxPackage -AllUsers};Write-Host "All preinstalled apps have been removed."

# install
# more dep TBD

choco install -y 7zip potplayer GoogleChrome dotnetfx sandboxie vscode

if ($env:full -ne $null) {
    choco install -y nodejs npm   
} 





   
    

