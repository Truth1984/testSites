#!/bin/bash

if $(u os rhel); then  
    sudo yum groupinstall "Server with GUI" -y
    sudo yum install tigervnc-server xrdp -y
    sudo systemctl start xrdp.service
    sudo systemctl enable xrdp.service
fi;

if $(u os ubuntu); then 
    sudo apt-get install ubuntu-desktop
    u install xrdp
    u service -e=xrdp
fi;
# port: 3389