# /bin/bash
# wget -O - https://truth1984.github.io/testSites/s/ssl.sh | bash

# configure ssl for server

if [ -x "$(command -v apt)" ]; then
    if ! [ -x  "$(command -v certbot)" ] || ! [ -x  "$(command -v nginx)" ] ; then
        sudo add-apt-repository universe
        sudo add-apt-repository ppa:certbot/certbot
        sudo apt-get update
        sudo apt-get install -y nginx
        sudo apt-get install -y python3-certbot-nginx
        sudo apt-get install -y certbot
        u service -e=nginx
    fi;
else
    if ! [ -x  "$(command -v certbot)" ] || ! [ -x  "$(command -v nginx)" ] ; then
        sudo yum install certbot nginx python3-certbot-nginx -y
        u service -e=nginx
    fi;
fi;

echo "sample nginx config:"
echo ""
echo 'server {
    server_name www.example.com example.com;
    location / {
        proxy_pass http://127.0.0.1:8000;
    }
}'
echo ""
echo "run certbot --nginx after configuring nginx"
