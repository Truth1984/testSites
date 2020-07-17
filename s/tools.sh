#!/bin/bash
# wget -O - https://truth1984.github.io/testSites/s/tools.sh | bash

common="nload psmisc net-tools nethogs openssh-server openssh-clients cronie"

if ! [ -x "$(command -v sudo)" ]; then
    apt-get update -y
    yum update -y

    apt-get install -y sudo
    yum install -y sudo 
fi;

if [ -x "$(command -v apt)" ]; then
    sudo apt-get install software-properties-common
    sudo apt-get install -y $common
fi;

if [ -x "$(command -v yum)" ]; then
    sudo yum install -y epel-release
    sudo yum install -y $common
fi;

if ! [ -x "$(command -v n)" ]; then
    common="curl screen npm"

    sudo apt-get install -y software-properties-common 
    sudo yum install -y epel-release 

    sudo apt-get install -y $common
    sudo yum install -y $common
    
    npm config set prefix $HOME/.npm_global
    npm config set registry https://registry.npm.taobao.org/
    npm i -g n
    n latest
    PATH="$PATH"
    
    npm i -g nodemon 
    npm i -g typescript 
    npm i -g trash-cli
    npm i -g yarn 
    yarn config set registry https://registry.npm.taobao.org -g
    yarn config set sass_binary_site http://cdn.npm.taobao.org/dist/node-sass -g
fi;

if ! [ -d "$HOME/Documents/ucmd" ]; then 
    git clone https://github.com/Truth1984/ucmd.git $HOME/Documents/ucmd
    cd $HOME/Documents/ucmd
    npm i -g .
    u quick pip3 "sudo python3 -m pip install ... -i https://mirrors.aliyun.com/pypi/simple/"
fi