# wget -O - https://truth1984.github.io/testSites/s/desktop.sh | bash
if $_gui; then
    if [ -f /etc/redhat-release ]; then
        sudo yum update -y
        sudo yum install -y ntfs-3g snapd samba
    fi;

    if [ -f /etc/debian_version ]; then
        sudo apt update -y
        sudo apt-get install -y snapd samba
    fi;

    if [ -x "$(command -v snap)" ]; then 
        # https://snapcraft.io/store
        sudo snap install postman
        sudo snap install code --classic
        sudo snap install mysql-workbench-community
    fi;
fi;
