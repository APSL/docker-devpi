#!/bin/bash
set -e

# If not set we use devpi host default value
if [ -z $DEVPI_DEFAULT_HOST ]; then
    DEVPI_DEFAULT_HOST=devpi
fi

# If not set we use devpi port default value
if [ -z $DEVPI_DEFAULT_PORT ]; then
    DEVPI_DEFAULT_PORT=8000
fi

sed -i -e "s/devpi_host:devpi_port/$DEVPI_DEFAULT_HOST:$DEVPI_DEFAULT_PORT/g"  /etc/nginx/nginx.conf

if [ "$1" = 'nginx-daemon' ]; then
    exec nginx -g "daemon off;";
fi

exec "$@"
