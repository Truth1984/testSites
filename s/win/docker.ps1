# install docker on powershell

Install-WindowsFeature containers

# restart server

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

Register-PSRepository -Default -InstallationPolicy Trusted
# or
Register-PSRepository -Name PSGallery -SourceLocation https://www.powershellgallery.com/api/v2/ -InstallationPolicy Trusted

# https://dscottraynsford.wordpress.com/2016/10/15/install-docker-on-windows-server-2016-using-dsc/

