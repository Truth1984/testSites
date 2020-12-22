#!/bin/bash
DIR="$(pwd)"
TINI_VERSION="v0.18.0"

if ! [ -f $DIR/package.json ]; then 
    echo this directory does not have package.json
    exit 1
fi;

if ! [ -f $DIR/dockerfile ]; then
    echo downloading node.docker
    wget -O $DIR/dockerfile https://truth1984.github.io/testSites/node/node.docker
    echo -e "node_modules
    package-lock*.json"> $DIR/.dockerignore
fi;

if ! [ -f docker-compose.yml ]; then
    echo downloading docker-compose.yml
    wget -O $DIR/docker-compose.yml https://truth1984.github.io/testSites/node/docker-compose.yml
    imageName="$(tr [A-Z] [a-z] <<< "$(basename $DIR)")"
    sudo docker image build -t $imageName . 
    u replace docker-compose.yml INAME $imageName
fi;

