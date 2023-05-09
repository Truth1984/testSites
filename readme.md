https://truth1984.github.io/testSites/

### fast

full:

```bash
preurl="https://raw.gitmirror.com/Truth1984/testSites/master/ss/setup.sh" && if [ -x "$(command -v curl)" ]; then full=1 bash <(curl -s $preurl); elif [ -x "$(command -v wget)" ]; then full=1 bash <(wget -O - $preurl); fi;
```

lite:

```bash
preurl="https://raw.gitmirror.com/Truth1984/testSites/master/ss/setup.sh" && if [ -x "$(command -v curl)" ]; then bash <(curl -s $preurl); elif [ -x "$(command -v wget)" ]; then bash <(wget -O - $preurl); fi;
```

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
$env:full=1; Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://raw.gitmirror.com/Truth1984/testSites/master/ss/setup.ps1'))

```

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install -y git wget

irm https://massgrave.dev/get | iex

# install u2 after setup wsl
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

### k8s common

```bash
bash <(curl -s https://truth1984.github.io/testSites/s/k8scommon.sh)
```
