#!/bin/bash
# bash <(curl -s https://truth1984.github.io/testSites/s/repo.sh)

if grep -q ubuntu /etc/os-release ; then 
    codename=$(env -i bash -c '. /etc/os-release; echo $VERSION_CODENAME')
    echo -e "
    deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ $codename main restricted universe multiverse
    deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ $codename main restricted universe multiverse
    deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ $codename-updates main restricted universe multiverse
    deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ $codename-updates main restricted universe multiverse
    deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ $codename-backports main restricted universe multiverse
    deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ $codename-backports main restricted universe multiverse
    deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ $codename-security main restricted universe multiverse
    deb-src https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ $codename-security main restricted universe multiverse
    " > /etc/apt/sources.list
fi;

if grep -q debian /etc/os-release ; then
    codename=$(dpkg --status tzdata|grep Provides|cut -f2 -d'-')
    echo -e "
    deb https://mirrors.tuna.tsinghua.edu.cn/debian/ $codename main contrib non-free
    deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ $codename main contrib non-free
    deb https://mirrors.tuna.tsinghua.edu.cn/debian/ $codename-updates main contrib non-free
    deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ $codename-updates main contrib non-free
    deb https://mirrors.tuna.tsinghua.edu.cn/debian/ $codename-backports main contrib non-free
    deb-src https://mirrors.tuna.tsinghua.edu.cn/debian/ $codename-backports main contrib non-free
    deb https://mirrors.tuna.tsinghua.edu.cn/debian-security $codename/updates main contrib non-free
    deb-src https://mirrors.tuna.tsinghua.edu.cn/debian-security $codename/updates main contrib non-free
    " > /etc/apt/sources.list
fi;

