#!/bin/bash
# bash <(curl -s https://truth1984.github.io/testSites/s/prescript-alma-d.sh)


printf 'nameserver\t8.8.8.8\nnameserver\t8.8.4.4\n' >> /etc/resolv.conf

yum update -y
yum install -y sudo redhat-lsb-core wget curl git epel-release screen

mkdir -p $HOME/Documents
mkdir -p $HOME/.application/tmp
touch $HOME/.bash_mine
touch $HOME/.bash_env
mkdir -p $HOME/.npm_global/lib

echo 'source $HOME/.bash_mine' >> $HOME/.bashrc
echo 'if [ "$PWD" = "$HOME" ]; then cd Documents; fi;' >> $HOME/.bash_mine
echo 'function cdd { _back=$(pwd) && cd $1 && ls -a; }' >> $HOME/.bash_mine
echo 'function cdb { _oldback=$_back && _back=$(pwd) && cd $_oldback && ls -a; }' >> $HOME/.bash_mine
echo 'PATH=$HOME/.npm_global/bin/:$PATH' >> $HOME/.bash_mine
echo 'source $HOME/.bash_env' >> $HOME/.bashrc
echo 'export no_proxy=localhost,127.0.0.1,10.96.0.0/12,192.168.0.0/16' >> $HOME/.bash_mine
echo 'export NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.0.0/16' >> $HOME/.bash_mine

# npm
yum install -y npm
npm config set registry "https://registry.npm.taobao.org"
npm config set prefix $HOME/.npm_global
echo "export NODE_PATH=$HOME/.npm_global/lib/node_modules" >> $HOME/.bash_mine
cd $HOME/.application/tmp
npm i n
sudo $HOME/.application/tmp/node_modules/n/bin/n latest
PATH="$PATH"
cd $HOME && sudo rm -rf $HOME/.application/tmp
source $HOME/.bashrc
npm i -g n nodemon
npm config set registry "http://registry.npmjs.org/"

# python
yum install -y python3-pip
sudo -H pip3 install --upgrade pip
python3 -m pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
sudo python3 -m pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
sudo -u root ln -s /usr/local/bin/pip3 /bin/pip3
    
# time and locale
localectl set-locale LANG=en_US.UTF-8
yum install -y systemd tzdata ntp initscripts chrony
sudo rm -rf /etc/localtime
sudo ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
timedatectl set-timezone Asia/Shanghai
timedatectl set-ntp true
TZ="Asia/Shanghai"
sudo chronyd -q
systemctl enable chronyd

# docker
sudo wget -O - https://get.docker.com | bash
sudo usermod -aG docker $(whoami)
sudo systemctl start docker.service
sudo systemctl enable docker.service
sudo pip3 install docker-compose

