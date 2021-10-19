#!/bin/bash

sudo yum groupinstall "Server with GUI" -y
sudo yum install tigervnc-server xrdp -y
sudo systemctl start xrdp.service
sudo systemctl enable xrdp.service

# port: 3389