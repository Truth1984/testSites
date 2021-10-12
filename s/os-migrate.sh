#!/bin/bash

#upgrade centos to almalinux

curl -O https://raw.githubusercontent.com/AlmaLinux/almalinux-deploy/master/almalinux-deploy.sh
chmod +x almalinux-deploy.sh
sudo ./almalinux-deploy.sh
rm -rf almalinux-deploy.sh