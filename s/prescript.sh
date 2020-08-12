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

if ! [ -f "$HOME/.bash_env" ]; then
    touch $HOME/.bash_env
    if ! cat $HOME/.bashrc | grep -q bash_env; then 
        echo 'source $HOME/.bash_env' >> $HOME/.bashrc
    fi;

    _ip=$(wget -qO- http://ipecho.net/plain | xargs echo)
    echo "export _ip=$_ip" >> $HOME/.bash_env

    if type Xorg 2>&1 | grep -q not; then
        echo "export _gui=false" >> $HOME/.bash_env
    else 
        echo "export _gui=true" >> $HOME/.bash_env
    fi
    
    source $HOME/.bashrc
fi;

if ! [ -x "$(command -v git)" ]; then
    sudo apt-get install -y git
    sudo yum install -y git

    git config --global alias.adog "log --all --decorate --oneline --graph"
fi;

if ! cat /etc/sysctl.conf | grep -q disable_ipv6; then
    sudo sh -c 'echo "net.ipv6.conf.all.disable_ipv6=1" >> /etc/sysctl.conf'
    sudo sh -c 'echo "net.ipv6.conf.default.disable_ipv6" >> /etc/sysctl.conf'
    sudo sysctl -p
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
    npm i n
    sudo $HOME/.application/tmp/node_modules/n/bin/n latest
    PATH="$PATH"   
    cd $HOME && sudo rm -rf $HOME/.application/tmp   

    npm i -g yarn n
    yarn config set registry https://registry.npm.taobao.org -g
    yarn config set prefix $HOME/.npm_global
    yarn config set sass_binary_site http://cdn.npm.taobao.org/dist/node-sass -g

    npm i -g nodemon typescript trash-cli eslint
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

    if [ -x "$(command -v firewall-cmd)" ]; then
        sudo firewall-cmd --zone=public --add-masquerade --permanent
        sudo firewall-cmd --zone=public --add-port=80/tcp
        sudo firewall-cmd --zone=public --add-port=443/tcp
        
        sudo firewall-cmd --reload
    fi

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
