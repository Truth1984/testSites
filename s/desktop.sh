# wget -O - https://truth1984.github.io/testSites/s/desktop.sh | bash
if $_gui; then
    if [ -f /etc/redhat-release ]; then
        sudo yum update -y
        sudo yum install -y ntfs-3g snapd samba ibus-libpinyin.x86_64 
    fi;

    if [ -f /etc/debian_version ]; then
        sudo apt update -y
        sudo apt-get install -y snapd samba install ibus-libpinyin
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
        sudo snap install postman
        sudo snap install code --classic
        sudo snap install mysql-workbench-community
        sudo snap install vlc
    fi;
fi;
