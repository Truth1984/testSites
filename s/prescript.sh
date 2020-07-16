if ! [ -f "$HOME/.bash_mine" ]; then
    touch $HOME/.bash_mine
    mkdir $HOME/.npm_global
    mkdir -p $HOME/.application/backup
    echo 'source $HOME/.bash_mine' >> $HOME/.bashrc
    echo 'if [ "$PWD" = "$HOME" ]; then cd Documents; fi;' >> $HOME/.bash_mine
    echo 'function cdd { cd $1 && ls -a; }' >> $HOME/.bash_mine
    echo 'PATH=$HOME/.npm_global/bin/:$PATH' >> $HOME/.bash_mine
    npm config set prefix $HOME/.npm_global
    source $HOME/.bashrc

    git config --global alias.adog "log --all --decorate --oneline --graph"
fi