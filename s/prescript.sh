#!/bin/bash
# bash <(curl -s https://truth1984.github.io/testSites/s/prescript.sh)
if ! [ -x "$(command -v sudo)" ]; then
    if [ -x "$(command -v apt)" ]; then 
        apt-get update -y
        apt-get install -y sudo
    fi;
    if [ -x "$(command -v yum)" ]; then 
        yum update -y
        yum install -y sudo 
        sudo yum install -y redhat-lsb-core
    fi;
fi;

shopt -s expand_aliases

if [ -x "$(command -v apt)" ]; then 
    alias ist='sudo apt-get install -y'
    alias istu='sudo apt-get upgrade -y'
elif [ -x "$(command -v yum)" ]; then 
    alias ist='sudo yum install -y'    
    alias istu='sudo yum upgrade -y'
elif [ -x "$(command -v dnf)" ]; then
    alias ist='sudo dnf install -y'
    alias istu='sudo dnf upgrade -y'
fi;

if ! [ -x "$(command -v wget)" ]; then
    ist wget
fi;

if ! [ -x "$(command -v curl)" ]; then
    ist curl
fi;

if [ -d /etc/apt ] && ! grep -q tsinghua /etc/apt/sources.list ; then 
    bash <(curl -s https://truth1984.github.io/testSites/s/repo.sh)
    sudo apt-get update
fi;

if ! cat /etc/resolv.conf | grep -q 8.8.8.8 ; then
    sudo sh -c "printf 'nameserver\t8.8.8.8\n' >> /etc/resolv.conf" 
    sudo sh -c "printf 'nameserver\t8.8.4.4\n' >> /etc/resolv.conf" 
fi;

if ! cat /etc/hosts | grep -q github ; then
    sudo sh -c "printf '151.101.48.133\traw.githubusercontent.com\n' >> /etc/hosts" 
    sudo sh -c "printf '140.82.114.4\tgithub.com\n' >> /etc/hosts"
fi;

if ! cat /etc/sysctl.conf | grep -q vm.max_map_count ; then
    sudo sh -c "echo 'vm.max_map_count=262144' >> /etc/sysctl.conf"
fi;

if ! [ -d "$HOME/Documents" ]; then 
    mkdir $HOME/Documents
fi

if ! [ -d "$HOME/.application" ]; then 
    mkdir -p $HOME/.application/backup
    mkdir -p $HOME/.application/empty
    mkdir -p $HOME/.application/logs
    sudo chmod 400 $HOME/.application/empty
fi

if ! [ -f "$HOME/.bash_mine" ]; then
    touch $HOME/.bash_mine
    mkdir -p $HOME/.npm_global

    echo 'source $HOME/.bash_mine' >> $HOME/.bashrc
    echo 'if [ "$PWD" = "$HOME" ]; then cd Documents; fi;' >> $HOME/.bash_mine
    echo 'function cdd { _back=$(pwd) && cd $1 && ls -a; }' >> $HOME/.bash_mine
    echo 'function cdb { _oldback=$_back && _back=$(pwd) && cd $_oldback && ls -a; }' >> $HOME/.bash_mine
    echo 'PATH=$HOME/.npm_global/bin/:$PATH' >> $HOME/.bash_mine
    source $HOME/.bashrc
fi

if ! [ -f "$HOME/.bash_env" ]; then
    touch $HOME/.bash_env
    if ! cat $HOME/.bashrc | grep -q bash_env; then 
        echo 'source $HOME/.bash_env' >> $HOME/.bashrc
    fi;

    u_ip=$(wget -qO- ident.me | xargs echo)
    echo "export u_ip=$u_ip" >> $HOME/.bash_env

    if type Xorg 2>&1 | grep -q not; then
        echo "export u_gui=false" >> $HOME/.bash_env
    else 
        echo "export u_gui=true" >> $HOME/.bash_env
    fi

    echo 'export u_name="appserver"' >> $HOME/.bash_env
    echo 'export u_describe="application server"' >> $HOME/.bash_env
    
    source $HOME/.bashrc
fi;

if ! [ -x "$(command -v git)" ]; then
    ist git
    git config --global alias.adog "log --all --decorate --oneline --graph"
fi;

if ! cat /etc/sysctl.conf | grep -q disable_ipv6; then
    sudo sh -c 'echo "net.ipv6.conf.all.disable_ipv6=1" >> /etc/sysctl.conf'
    sudo sh -c 'echo "net.ipv6.conf.default.disable_ipv6=1" >> /etc/sysctl.conf'
    sudo sh -c "echo 'fs.inotify.max_user_watches=524288' >> /etc/sysctl.conf"
    sudo sysctl -p
fi;

if ! [ -x "$(command -v n)" ]; then
    if [ -x "$(command -v apt)" ]; then 
        ist software-properties-common 
        
    fi;
    if [ -x "$(command -v yum)" ]; then 
        ist epel-release 
    fi;  

    ist curl screen npm
    
    npm config set registry "http://registry.npmjs.org/"
    npm config set prefix $HOME/.npm_global
    echo "export NODE_PATH=$HOME/.npm_global/lib/node_modules" >> $HOME/.bash_mine

    mkdir -p $HOME/.npm_global/lib

    mkdir -p $HOME/.application/tmp
    cd $HOME/.application/tmp
    npm i n
    sudo $HOME/.application/tmp/node_modules/n/bin/n latest
    PATH="$PATH"   
    cd $HOME && sudo rm -rf $HOME/.application/tmp   
    
    source $HOME/.bashrc
    npm i -g yarn n
    source $HOME/.bashrc
    $HOME/.npm_global/bin/yarn config set registry https://registry.npm.taobao.org -g
    $HOME/.npm_global/bin/yarn config set prefix $HOME/.npm_global
    $HOME/.npm_global/bin/yarn config set sass_binary_site http://cdn.npm.taobao.org/dist/node-sass -g

    npm i -g nodemon trash-cli awadau backend-core
    source $HOME/.bashrc
fi;

if ! [ -x "$(command -v python3)" ] || ! [ -f $HOME/.config/pip/pip.conf ] ; then
    ist python3-pip 
    sudo -H pip3 install --upgrade pip
    sudo python3 -m pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
fi;

if ! [ $LANG = en_US.UTF-8 ]; then
    localectl set-locale LANG=en_US.UTF-8
fi;

if ! [ -x "$(command -v chronyd)" ]; then
    ist systemd tzdata ntp
    sudo rm -rf /etc/localtime
    sudo ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    timedatectl set-timezone Asia/Shanghai
    timedatectl set-ntp true
    echo "TZ='Asia/Shanghai'; export TZ" >> ~/.profile

    ist chrony 
    sudo chronyd -q
    sudo systemctl restart chronyd
fi

if ! [ -x "$(command -v snap)" ]; then 
    ist snapd
    sudo systemctl enable --now snapd.socket
fi;

if ! [ -d /snap ]; then
    sudo ln -s /var/lib/snapd/snap /snap
fi;

if ! [ -x "$(command -v docker)" ]; then 
    echo docker

    if [ -x "$(command -v firewall-cmd)" ]; then
        sudo firewall-cmd --zone=public --add-masquerade --permanent
        sudo firewall-cmd --zone=public --add-port=80/tcp
        sudo firewall-cmd --zone=public --add-port=443/tcp
        
        sudo firewall-cmd --reload
    fi

    sudo wget -O - https://get.docker.com | bash

    sudo systemctl start docker.service
    sudo systemctl enable docker.service
fi;

if ! [ -x "$(command -v docker-compose)" ]; then
    # istu python3
    sudo pip3 install docker-compose
fi;
