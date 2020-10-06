#!/bin/bash

if ! [ -d "$HOME/Documents" ]; then 
    mkdir $HOME/Documents
fi

if ! [ -d "$HOME/.application" ]; then 
    mkdir -p $HOME/.application/backup
    mkdir -p $HOME/.application/empty
    chmod 400 $HOME/.application/empty
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

choco install -y nodejs

if ! [ -x "$(command -v yarn)" ]; then
    common="curl screen npm"
    
    npm config set prefix $HOME/.npm_global
    npm i -g yarn   
    source $HOME/.bashrc 
    
    yarn config set registry https://registry.npm.taobao.org -g
    yarn config set prefix $HOME/.npm_global
    yarn config set sass_binary_site http://cdn.npm.taobao.org/dist/node-sass -g 
    source $HOME/.bashrc 
    PATH="$PATH"
    
    yarn global add nodemon typescript trash-cli
    source $HOME/.bashrc
fi;

if ! [ -d "$HOME/Documents/ucmd" ]; then 
    git clone https://github.com/Truth1984/ucmd.git $HOME/Documents/ucmd
    cd $HOME/Documents/ucmd
    # yarn global add $PWD
    npm run build
fi;

choco install -y GoogleChrome adobereader \
openssh 7zip python3 dotnetfx filezilla \
teamviewer vscode libreoffice-fresh \
postman cmder docker-cli docker-compose f.lux \
360ts epicgameslauncher potplayer
