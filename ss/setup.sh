#!/bin/bash
# full=1 bash <(curl -s https://truth1984.github.io/testSites/ss/setup.sh)
# TBD tools

# install

echo SCRIPT_VERSION=1.0.2

ssurl="https://raw.gitmirror.com/Truth1984/shell-simple/main/util.sh"; if $(command -v curl &> /dev/null); then curl $ssurl -o util.sh; elif $(command -v wget &> /dev/null); then wget -O util.sh $ssurl; fi; chmod 777 util.sh && ./util.sh setup && source ~/.bash_mine

if [[ -z "$(command -v u2)" ]]; then echo u2 not setup correctly && exit 1; fi;

if $(u2 os -c alpine); then
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
fi;

if $(u2 hasFile /etc/apt/sources.list); then
    sed -i 's/http.*[^security].com/https:\/\/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
    sed -i 's/http.*[^security].org/https:\/\/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
fi;

u2 upgrade

## extra dep

u2 install wget curl nano git make

if $(u2 os -c yum); then
    u2 install redhat-lsb-core epel-release
fi;

if $(u2 os -c apt); then
    u2 install software-properties-common
fi;

## not windows

if ! $(u2 os -c win); then

    if ! $(u2 hasCmd sudo); then
        u2 install sudo
    fi;

    if $(u2 hasValue $full); then
        u2 install screen
    fi;

    if ! $(u2 hasCmd chronyd); then
        u2 install chrony
        timedatectl set-timezone Asia/Shanghai
        sudo chronyd -q
        sudo systemctl enable chronyd.service
    fi;

fi;

## + ssh

if ! $(u2 hasCmd ssh); then 
    if $(u2 os -c apt); then u2 install openssh-server openssh-client;
        elif $(u2 os -c dnf); then u2 install openssh openssh-server;
        elif $(u2 os -c yum); then u2 install openssh openssh-server;
        elif $(u2 os -c pacman); then u2 install openssh;
    fi;
fi;

## full + node docker

if $(u2 hasValue $full); then

    if ! $(u2 hasCmd node); then 
        curl -L https://bit.ly/n-install | bash -s -- -y
        source ~/.bashrc
        mkdir -p $HOME/.npm_global/lib
        npm config set registry "http://registry.npmjs.org/"
        npm config set prefix $HOME/.npm_global
        echo "export NODE_PATH=$HOME/.npm_global/lib/node_modules" >> $HOME/.bash_mine
    fi; 

    if ! $(u2 hasCmd docker); then 
        u2 install docker
        sudo usermod -aG docker $(whoami)
        # sudo wget -O - https://get.docker.com | bash

        if $(u2 hasCmd systemctl); then
            sudo systemctl start docker.service
            sudo systemctl enable docker.service
        fi;
    fi;

fi;

## gui + ibus-libpinyin samba FiraCode

if $(u2 hasCmd Xorg || u2 hasValue $XDG_SESSION_TYPE); then
    u2 install ibus-libpinyin samba

    font_path=~/.application/fonts
    if ! $(u2 hasDir $font_path); then
        mkdir $font_path
        for type in Bold Light Medium Regular Retina; do
            u2 download "https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true" "$font_path/FiraCode-${type}.ttf"
        done
        fc-cache -f
    fi;
    
fi;

## conf

if ! cat /etc/resolv.conf | grep -q 8.8.8.8 ; then
    sudo sh -c "printf 'nameserver\t1.1.1.1\n' >> /etc/resolv.conf"
    sudo sh -c "printf 'nameserver\t8.8.8.8\n' >> /etc/resolv.conf"
    sudo sh -c "printf 'nameserver\t8.8.4.4\n' >> /etc/resolv.conf"
fi;

if $(u2 hasFile /etc/systemd/resolved.conf) && ! $(u2 hasContent /etc/systemd/resolved.conf 'DNS=1.1.1.1'); then
    sudo sh -c "printf 'DNS=1.1.1.1 8.8.8.8 8.8.4.4\n' >> /etc/systemd/resolved.conf" 
fi;

mkdir -p $HOME/Documents
mkdir -p $HOME/.application/backup
mkdir -p $HOME/.application/empty
mkdir -p $HOME/.application/logs
chmod 400 $HOME/.application/empty
