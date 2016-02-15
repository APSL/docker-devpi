#!/bin/bash

if [ "$1" = 'devpi-server' ]; then
    if [ ! -f  /data/server/.serverversion ]; then
        echo "[RUN]: Initialise devpi-server"
        devpi-server --restrict-modify root --start --serverdir /data/server --host 127.0.0.1 --port 8000 
        devpi-server --serverdir /data/server --status
        devpi use http://localhost:8000
        devpi login root --password=''
        devpi user -m root password="${DEVPI_PASSWORD}"
        devpi index -y -c public pypi_whitelist='*'
        devpi-server --stop --serverdir /data/server
        devpi-server --status --serverdir /data/server
        htpasswd -cb /data/htpasswd root ${DEVPI_PASSWORD}
    fi
    
    if [ -n "${OUTSIDE_URL}" ]; then
        OUTSIDE_URL_PARAMETER="--outside-url ${OUTSIDE_URL}"
    fi
    
    if [ -n "${DEBUG}" ]; then
        DEBUG_PARAMETER="--debug"
    fi
    echo "[RUN]: Launching devpi-server"
    exec devpi-server --restrict-modify root --serverdir /data/server --host 0.0.0.0 --port 8000 ${OUTSIDE_URL_PARAMETER} ${DEBUG_PARAMETER}
fi

echo "[RUN]: Builtin command not provided [devpi]"
echo "[RUN]: $@"

exec "$@" 
