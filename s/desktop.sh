# wget -O - https://truth1984.github.io/testSites/s/desktop.sh | bash
if $_gui; then
    if [ -f /etc/redhat-release ]; then
        sudo yum update
        sudo yum install ntfs-3g
    fi;
fi;

