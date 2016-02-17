#!/bin/bash

echo "[RUN] Create user or modify password in htpasswd"
echo "[RUN] htpasswd -b /data/htpasswd $1 $2"
htpasswd -b /data/htpasswd $1 $2

echo "[RUN] Login to devpi with root user"
URL=`echo $OUTSIDE_URL |sed 's/https\?:\/\///'`
PROTOCOL=`echo $OUTSIDE_URL| awk -F: '{print $1}'`
echo "[RUN] devpi use ${PROTOCOL}://root:${DEVPI_PASSWORD}@${URL}"
devpi use ${PROTOCOL}://root:${DEVPI_PASSWORD}@${URL}
devpi login root --password="${DEVPI_PASSWORD}"


USER_EXISTS=`devpi user -l|grep -Fx $1|wc -l`
if [[ $USER_EXISTS == 1 ]]
then
  echo "[RUN] Modifying user $1 in devpi"
  echo "[RUN] devpi user -m $1 password='$2'"
  devpi user -m $1 password="$2"
else
  echo "[RUN] Create user $1 in devpi"
  echo "[RUN] devpi user -c $1 password='$2'"
  devpi user -c $1 password="$2"
fi