https://truth1984.github.io/testSites/

### bash

```bash
preurl="https://truth1984.github.io/testSites/s/prescript.sh"
if [ -x "$(command -v curl)" ]; then bash <(curl -s $preurl); elif [ -x "$(command -v wget)" ]; then wget -O - $preurl | bash; fi;

toolurl="https://truth1984.github.io/testSites/s/tools.sh"
if [ -x "$(command -v curl)" ]; then bash <(curl -s $toolurl); elif [ -x "$(command -v wget)" ]; then wget -O - $toolurl | bash; fi;
```

### powershell

prerequisite : .net 4.5 `$psversiontable`

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install -y git wget

& 'C:\Program Files\Git\bin\bash.exe' -c 'wget -O - https://truth1984.github.io/testSites/s/win/desktop.sh | bash'
```

### info

```bash
bash <(curl -s https://truth1984.github.io/testSites/s/info.sh)
```

### lite

ignore docker install

```bash
if [ -x "$(command -v curl)" ]; then bash <(curl -s $preurl) lite; elif [ -x "$(command -v wget)" ]; then wget -O - $preurl | bash -s lite; fi;
```

### os-migrate (centos to AlmaLinux)

```bash
bash <(curl -s https://truth1984.github.io/testSites/s/os-migrate.sh)
```
