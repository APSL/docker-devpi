#!/bin/bash

if [ "$1" = 'devpi-server' ]; then
    if [ ! -f  /data/.devpi/server/.serverversion ]; then
        echo "[RUN]: Initialise devpi-server"
        devpi-server --restrict-modify root --start --host 127.0.0.1 --port 8000 
        devpi-server --status
        devpi use http://localhost:8000
        devpi login root --password=''
        devpi user -m root password="${DEVPI_PASSWORD}"
        devpi index -y -c public pypi_whitelist='*'
        devpi-server --stop
        devpi-server --status
    fi
    
    if [ -n "$OUTSIDE_URL" ]; then
        OUTSIDE_URL_PARAMETER="--outside-url $OUTSIDE_URL"
    fi
    
    echo "[RUN]: Launching devpi-server"
    exec devpi-server --restrict-modify root --host 0.0.0.0 --port 8000 ${OUTSIDE_URL_PARAMETER}
fi

echo "[RUN]: Builtin command not provided [devp]"
echo "[RUN]: $@"

exec "$@" 
