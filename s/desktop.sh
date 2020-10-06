#!/bin/bash
# wget -O - https://truth1984.github.io/testSites/s/desktop.sh | bash
if $_gui; then
    if [ -f /etc/redhat-release ]; then
        sudo yum update -y
        sudo yum install -y ntfs-3g snapd samba ibus-libpinyin.x86_64 open-vm-tools-desktop
    fi;

    if [ -f /etc/debian_version ]; then
        sudo apt update -y
        sudo apt-get install -y snapd samba install ibus-libpinyin open-vm-tools-desktop
    fi;

    if ! [ -d $HOME/.local/share/fonts ]; then
        mkdir -p $HOME/.local/share/fonts
        for type in Bold Light Medium Regular Retina; do
            file_path="${HOME}/.local/share/fonts/FiraCode-${type}.ttf"
            file_url="https://github.com/tonsky/FiraCode/blob/master/distr/ttf/FiraCode-${type}.ttf?raw=true"
            echo "wget -O $file_path $file_url"
            wget -O "${file_path}" "${file_url}"
        done
        fc-cache -f
    fi;

    if [ -x "$(command -v snap)" ]; then 
        # https://snapcraft.io/store
        sudo snap install code --classic
        sudo snap install postman
        sudo snap install mysql-workbench-community
        sudo snap install vlc
    fi;

    if ! sudo docker image ls | grep -q wine-stable ; then
        sudo docker pull thawsystems/wine-stable
        u quick wine "sudo docker run -it wine-stable wine"
    fi;

    if [ -x "$(command -v jupyter)" ]; then 
        sudo pip3 install jupyterlab
        u quick jpn "jupyter notebook --ip=127.0.0.1 --port=9013"
        u quick jpl "jupyter-lab --ip=127.0.0.1 --port=9014"
    fi;
fi;
