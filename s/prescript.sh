#!/bin/bash
# wget -O - https://truth1984.github.io/testSites/s/prescript.sh | bash
if ! [ -x "$(command -v sudo)" ]; then
    apt-get update -y
    yum update -y

    apt-get install -y sudo
    yum install -y sudo 
fi;

if [ -f /etc/apt/sources.list ] && ! cat /etc/apt/sources.list | grep -q aliyun ; then
    sudo apt-get install -y lsb-release
    sudo sh -c "echo \"
    deb http://mirrors.aliyun.com/ubuntu/ $(lsb_release -c -s) main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu/ $(lsb_release -c -s)-security main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu/ $(lsb_release -c -s)-updates main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu/ $(lsb_release -c -s)-proposed main restricted universe multiverse
    deb http://mirrors.aliyun.com/ubuntu/ $(lsb_release -c -s)-backports main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ $(lsb_release -c -s) main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ $(lsb_release -c -s)-security main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ $(lsb_release -c -s)-updates main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ $(lsb_release -c -s)-proposed main restricted universe multiverse
    deb-src http://mirrors.aliyun.com/ubuntu/ $(lsb_release -c -s)-backports main restricted universe multiverse\" > /etc/apt/sources.list"
    
    sudo apt-get update
fi

if ! [ -f "$HOME/.bash_mine" ]; then
    touch $HOME/.bash_mine
    mkdir -p $HOME/.npm_global
    mkdir -p $HOME/.application/backup
    echo 'source $HOME/.bash_mine' >> $HOME/.bashrc
    echo 'if [ "$PWD" = "$HOME" ]; then cd Documents; fi;' >> $HOME/.bash_mine
    echo 'function cdd { cd $1 && ls -a; }' >> $HOME/.bash_mine
    echo 'PATH=$HOME/.npm_global/bin/:$PATH' >> $HOME/.bash_mine
    source $HOME/.bashrc
fi

if ! [ -x "$(command -v git)" ]; then
    sudo apt-get install -y git
    sudo yum install -y git

    git config --global alias.adog "log --all --decorate --oneline --graph"
fi;

if ! [ -x "$(command -v n)" ]; then
    common="curl screen npm"

    sudo apt-get install -y software-properties-common $common
    sudo yum install -y epel-release $common
    
    npm config set prefix $HOME/.npm_global
    npm config set registry https://registry.npm.taobao.org/
    npm i -g n
    n latest
    npm i -g n yarn nodemon npm typescript trash-cli
    yarn config set registry https://registry.npm.taobao.org -g
    yarn config set sass_binary_site http://cdn.npm.taobao.org/dist/node-sass -g
fi;

if ! [ -x "$(command -v python3)"  ]; then
    sudo apt-get install -y python3-pip libmysqlclient-dev
    sudo yum install -y python3-pip libmysqlclient-dev
    sudo -H pip3 install --upgrade pip
fi;

if  ! [ -x "$(command -v docker)" ]; then 
    echo docker
    yum remove docker \
        docker-client \
        docker-client-latest \
        docker-common \
        docker-latest \
        docker-latest-logrotate \
        docker-logrotate \
        docker-engine && yum install -y yum-utils && yum-config-manager \
        --add-repo \
        https://download.docker.com/linux/centos/docker-ce.repo 
    yum install -y docker-ce docker-ce-cli containerd.io

    sudo add-apt-repository deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable
    sudo apt-get update 
    sudo apt-get install docker-ce docker-ce-cli containerd.io

    echo docker compose
    curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    chmod +x /usr/local/bin/docker-compose
fi;
