#!/bin/bash
# wget -O - https://truth1984.github.io/testSites/s/project.sh | bash

if ! [ -d node_modules ]; then
    echo "project missing node_modules"
    exit 1
fi;

u gitclone "backend-core" node_modules
npm install --prefix node_modules/backend-core 