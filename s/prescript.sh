#!/bin/bash
# wget -O - https://truth1984.github.io/testSites/s/prescript.sh | bash
if ! [ -x "$(command -v sudo)" ]; then
    apt-get update -y
    yum update -y

    apt-get install -y sudo
    yum install -y sudo 
    sudo yum install -y redhat-lsb-core
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

if ! [ -d "$HOME/Documents" ]; then 
    mkdir $HOME/Documents
fi

if ! [ -d "$HOME/.application" ]; then 
    mkdir -p $HOME/.application/backup
    mkdir -p $HOME/.application/empty
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

if ! [ -x "$(command -v git)" ]; then
    sudo apt-get install -y git
    sudo yum install -y git

    git config --global alias.adog "log --all --decorate --oneline --graph"
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

if ! [ -x "$(command -v python3)"  ]; then
    sudo apt-get install -y python3-pip libmysqlclient-dev
    sudo yum install -y python3-pip libmysqlclient-dev
    sudo -H pip3 install --upgrade pip
fi;

if ! [ $LANG = en_US.UTF-8 ]; then
    localectl set-locale LANG=en_US.UTF-8
fi;

if ! [ -x "$(command -v chronyd)" ]; then
    sudo apt-get install -y systemd tzdata ntp
    sudo yum install -y systemd tzdata ntp
    sudo rm -rf /etc/localtime
    sudo ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
    timedatectl set-timezone Asia/Shanghai
	timedatectl set-ntp true
    echo "TZ='Asia/Shanghai'; export TZ" >> ~/.profile

    sudo apt-get install -y chrony 
    sudo yum install -y chrony
    sudo chronyd -q
    sudo systemctl restart chronyd
fi

if  ! [ -x "$(command -v docker)" ]; then 
    echo docker
    sudo yum remove docker \
        docker-client \
        docker-client-latest \
        docker-common \
        docker-latest \
        docker-latest-logrotate \
        docker-logrotate \
        docker-engine 
	
    sudo yum install -y yum-utils 
    sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    sudo dnf install https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.10-3.2.el7.x86_64.rpm
    sudo yum install -y docker-ce docker-ce-cli 

    sudo add-apt-repository deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable
    sudo apt-get update 
    sudo apt-get install docker-ce docker-ce-cli containerd.io
    
    sudo systemctl start docker.service
    sudo systemctl enable docker.service
fi;

if ! [ -x "$(command -v docker-compose)" ]; then
    sudo curl -L "https://github.com/docker/compose/releases/download/1.26.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
fi;
