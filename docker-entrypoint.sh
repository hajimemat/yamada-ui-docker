#!/bin/bash

set -eo pipefail
shopt -s nullglob

export HOST_UID=${HOST_UID:-1000}
export HOST_GID=${HOST_GID:-1000}
export PACKAGE_NAME=${PACKAGE_NAME:-"yamada-app"}

usermod -u ${HOST_UID} -g ${HOST_GID} node 2>&1 > /dev/null


function initialize {
    if [ ! -d node_modules ]
    then
        cp -aT /usr/share/yamada-skelton/next ./
        if [ ! -f package.json ]
        then
            envsubst < /usr/share/yamada-skelton/package.json.nextjs-template > package.json
        fi
        if [ ! -d packages ]
        then
            mkdir packages
            cp -r /usr/share/yamada-ui packages
        fi
    fi
    chown node:node -R .
}

case $1 in
    debug)
        _main="echo $@"
        ;;
    bash)
        _main="$@"
        initialize
        ;;
    cat)
        _main="$@"
        initialize
        ;;
    run)
        _main="pnpm $@"
        initialize
        su-exec node pnpm install
        ;;
    *)
        _main="pnpm $@"
        initialize
        ;;
esac

su-exec node $_main
