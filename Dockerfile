FROM python:2.7.10-slim
MAINTAINER Edu Herraiz <gshark@gmail.com>

VOLUME /data

# Things required for a python/pip environment
COPY system-requirements.txt /usr/src/app/system-requirements.txt
RUN  \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get -y autoremove && \
    xargs apt-get -y -q install < /usr/src/app/system-requirements.txt && \
    apt-get clean

COPY requirements.txt /usr/src/app/requirements.txt
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

COPY create-user.sh /sbin/create-user

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["devpi-server"]

EXPOSE 8000