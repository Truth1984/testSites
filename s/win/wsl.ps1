
# enable "Windows Subsystem for Linux"
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart

# Enable Virtual Machine feature
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart

# Enabling Hyper-V
dism.exe /online /enable-feature /featurename:Microsoft-Hyper-V /all /norestart

dism.exe /online /enable-feature /featurename:containers /all /norestart

wsl --set-default-version 2

wsl --install -d Ubuntu

# enable samba
# dism.exe /online /enable-feature /featurename:SMB1Protocol /all /norestart

# restart
# change ubuntu file permission
# 1. `bash`
# printf '[automount]\nenabled  = true\nroot     = /mnt/\noptions  = "metadata,umask=22,fmask=11"' > /etc/wsl.conf

# init dbus
# git clone https://github.com/DamionGans/ubuntu-wsl2-systemd-script.git
# cd ubuntu-wsl2-systemd-script/
# bash ubuntu-wsl2-systemd-script.sh

# 2. `cmd`
# wsl --shutdown

