#!/bin/bash
# bash <(curl -s https://truth1984.github.io/testSites/s/tools.sh)

common="git nano nload e2fsprogs psmisc net-tools nethogs openssh-server iptables udisks2"

if [ -x "$(command -v apt)" ]; then
    sudo apt-get install software-properties-common
    sudo apt-get install -y $common cron openssh-client silversearcher-ag
fi;

if [ -x "$(command -v yum)" ]; then
    sudo yum install -y epel-release
    sudo yum install -y $common cronie openssh-clients the_silver_searcher
fi;

if ! [ -d "$HOME/Documents/ucmd" ]; then 
    git clone https://github.com/Truth1984/ucmd.git $HOME/Documents/ucmd
    cd $HOME/Documents/ucmd
    # yarn global add $PWD
    npm run build

    source $HOME/.bashrc
    
    if [ -x "$(command -v docker-compose)" ]; then
        u link docker-compose
    fi;
    
    u quick pip3 "sudo python3 -m pip install ... -i https://mirrors.aliyun.com/pypi/simple/"
    u quick noip6 "sudo sysctl -p"
fi

if [ -x "$(command -v ansible)" ]; then
    u quick pip3 -a="ansible"
fi;

if $u_gui && ! npm list -g | grep -q typescript; then 
    npm i -g eslint typescript jest eslint-plugin-jest @types/jest
fi;