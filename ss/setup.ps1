# $env:full=1 & Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.gitmirror.com/Truth1984/testSites/master/ss/setup.ps1'))

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# install git

choco install -y git curl

Set-Location "C:\Program Files\Git"

# init u2

bash -c 'preurl="https://raw.gitmirror.com/Truth1984/testSites/master/ss/setup.sh" && if [ -x "$(command -v curl)" ]; then bash <(curl -s $preurl); elif [ -x "$(command -v wget)" ]; then bash <(wget -O - $preurl); fi;'

# install
# more dep TBD

choco install -y 7zip potplayer GoogleChrome vscode dotnetfx 

if (Test-Path env:full){
    choco install -y f.lux nodejs npm   
} 





   
    

