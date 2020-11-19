https://truth1984.github.io/testSites/

### bash

```bash
wget -O - https://truth1984.github.io/testSites/s/prescript.sh | bash

wget -O - https://truth1984.github.io/testSites/s/tools.sh | bash
```

### powershell

prerequisite : .net 4.5 `$psversiontable`

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install -y git wget

& 'C:\Program Files\Git\bin\bash.exe' -c 'wget -O - https://truth1984.github.io/testSites/s/win/desktop.sh | bash'
```
