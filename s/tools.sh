#!/bin/bash
# bash <(curl -s https://truth1984.github.io/testSites/s/tools.sh)

common="git nano nload e2fsprogs psmisc net-tools nethogs openssh-server iptables udisks2"

source $HOME/.bashrc

if [ -x "$(command -v apt)" ]; then
    sudo apt-get install software-properties-common
    sudo apt-get install -y $common 
    sudo apt-get install -y cron openssh-client silversearcher-ag
fi;

if [ -x "$(command -v yum)" ]; then
    sudo yum install -y epel-release
    sudo yum install -y $common 
    sudo yum install -y cronie openssh-clients the_silver_searcher
fi;

if [ -x "$(command -v brew)" ]; then
    if [ ! -d /usr/local/sbin ]; then 
        sudo mkdir /usr/local/sbin && sudo chmod 777 /usr/local/sbin
        echo 'export PATH=/usr/local/sbin:$PATH' >> $HOME/.bashrc
    fi;
    brew install git wget nethogs the_silver_searcher
fi;

if ! [ -d "$HOME/Documents/ucmd2" ]; then 
    git clone https://github.com/Truth1984/ucmd2.git $HOME/Documents/ucmd2
    cd $HOME/Documents/ucmd2
    # yarn global add $PWD
    npm run build

    source $HOME/.bashrc
    
    if [ -x "$(command -v docker-compose)" ]; then
        u link docker-compose
    fi;
    
    u quick pip3 -c "sudo python3 -m pip install ... -i https://mirrors.aliyun.com/pypi/simple/"
    u quick noip6 -c "sudo sysctl -p"
fi

if [ -x "$(command -v ansible)" ]; then
    u quick pip3 -a="ansible"
fi;

if $u_gui && ! npm list -g | grep -q typescript; then 
    npm i -g eslint typescript jest eslint-plugin-jest @types/jest
fi;