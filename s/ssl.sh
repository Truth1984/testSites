# /bin/bash
# wget -O - https://truth1984.github.io/testSites/s/ssl.sh | bash

read -p "project name? " project
read -p "urls: www.example.com ?" urls
read -p "http port?" port

shortName=$(u regex "$urls" -B=www.,\$)

if ! [ -x "$(command -v apt)" ]; then
    if ! [ -x  "$(command -v certbot)" ] || ! [ -x  "$(command -v nginx)" ] ; then
        sudo add-apt-repository universe
        sudo add-apt-repository ppa:certbot/certbot
        sudo apt-get update
        sudo apt-get install certbot python-certbot-nginx nginx
        u service -e=nginx
    fi;
else
    if ! [ -x  "$(command -v certbot)" ] || ! [ -x  "$(command -v nginx)" ] ; then
        sudo yum install certbot nginx
        u service -e=nginx
    fi;
fi;

if ! [ -f /etc/nginx/conf.d/$project.conf ]; then 
   printf "server {\n\tlisten 80;\n\tlisten [::]:80;\n\tserver_name \
   $urls $shortName localhost;\n\tlocaltion / {\n\t\tproxy_pass http://localhost:$port\n\t}" \ 
   > /etc/nginx/conf.d/$project.conf
   sudo nginx -t && sudo nginx -s reload && sudo certbot --nginx && sudo certbot renew --dry-run
fi;