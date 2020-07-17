#!/bin/bash
# wget -O - https://truth1984.github.io/testSites/s/tools.sh | bash

common="nload psmisc net-tools nethogs openssh-server openssh-clients cronie"

if [ -x "$(command -v apt)" ]; then
    sudo apt-get install -y $common
fi;

if [ -x "$(command -v yum)" ]; then
    sudo yum install -y epel-release
    sudo yum install -y $common
fi;

if ! [ -d "$HOME/Documents/ucmd" ]; then 
    git clone https://github.com/Truth1984/ucmd.git $HOME/Documents/ucmd
    cd $HOME/Documents/ucmd
    npm i -g .
    u quick pip3 "sudo python3 -m pip install ... -i https://mirrors.aliyun.com/pypi/simple/"
fi