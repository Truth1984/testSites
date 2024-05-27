#!/bin/bash
#!/bin/ash

source ~/.bash_mine && shopt -s expand_aliases

if $(u2 os -c alpine); then
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories
    apk update
fi;

if $(u2 hasFile /etc/apt/sources.list); then
    sed -i 's/http.*[^security].com/https:\/\/mirrors.tuna.tsinghua.edu.cn/g' /etc/apt/sources.list
    apt-get clean
    apt-get update
fi;

