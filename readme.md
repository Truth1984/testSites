https://truth1984.github.io/testSites/

### bash

```bash
wget -O - https://truth1984.github.io/testSites/s/prescript.sh | bash
```

### powershell

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://truth1984.github.io/testSites/s/win/prescript.html'))
```