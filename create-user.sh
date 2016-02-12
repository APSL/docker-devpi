#!/bin/bash

echo "[RUN] htpasswd -b /data/htpasswd $1 $2"
htpasswd -b /data/htpasswd $1 $2
echo "[RUN] devpi use http://root:${DEVPI_PASSWORD}@${OUTSIDE_URL}"
devpi use http://root:${DEVPI_PASSWORD}@${OUTSIDE_URL}
echo "[RUN] devpi login root --password='${DEVPI_PASSWORD}'"
devpi login root --password="${DEVPI_PASSWORD}"
echo "[RUN] devpi user -c $1 password='$2'"
devpi user -c $1 password="$2"


