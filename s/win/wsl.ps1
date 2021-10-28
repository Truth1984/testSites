
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


