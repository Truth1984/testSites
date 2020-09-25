#!/bin/bash
# wget -O - https://truth1984.github.io/testSites/s/tools.sh | bash

common="git nano nload e2fsprogs psmisc net-tools nethogs openssh-server iptables"

if ! [ -x "$(command -v sudo)" ]; then
    apt-get update -y
    yum update -y

    apt-get install -y sudo
    yum install -y sudo 
fi;

if [ -x "$(command -v apt)" ]; then
    sudo apt-get install software-properties-common
    sudo apt-get install -y $common cron openssh-client
fi;

if [ -x "$(command -v yum)" ]; then
    sudo yum install -y epel-release
    sudo yum install -y $common cronie openssh-clients
fi;

if ! [ -x "$(command -v n)" ]; then
    common="curl screen npm"

    sudo apt-get install -y software-properties-common 
    sudo yum install -y epel-release 

    sudo apt-get install -y $common
    sudo yum install -y $common
    
    npm config set prefix $HOME/.npm_global

    mkdir -p $HOME/.application/tmp
    cd $HOME/.application/tmp
    npm i n yarn
    sudo $HOME/.application/tmp/node_modules/n/bin/n latest
    PATH="$PATH"   
    
    $HOME/.application/tmp/node_modules/yarn/bin/yarn config set registry https://registry.npm.taobao.org -g
    $HOME/.application/tmp/node_modules/yarn/bin/yarn config set prefix $HOME/.npm_global
    $HOME/.application/tmp/node_modules/yarn/bin/yarn config set sass_binary_site http://cdn.npm.taobao.org/dist/node-sass -g
    $HOME/.application/tmp/node_modules/yarn/bin/yarn global add n yarn 
    source $HOME/.bashrc 
    PATH="$PATH"
  
    cd $HOME && sudo rm -rf $HOME/.application/tmp   
    
    yarn global add nodemon typescript trash-cli
    source $HOME/.bashrc
fi;

if ! [ -d "$HOME/Documents/ucmd" ]; then 
    git clone https://github.com/Truth1984/ucmd.git $HOME/Documents/ucmd
    cd $HOME/Documents/ucmd
    # yarn global add $PWD
    npm run build
    
    if [ -x "$(command -v docker-compose)" ]; then
        u link docker-compose
    fi;
    
    u quick pip3 "sudo python3 -m pip install ... -i https://mirrors.aliyun.com/pypi/simple/"
    u quick noip6 "sudo sysctl -p"
fi
