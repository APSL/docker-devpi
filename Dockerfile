FROM python:2.7.10-slim
MAINTAINER Edu Herraiz <gshark@gmail.com>

VOLUME /data

COPY requirements.txt /usr/src/app/requirements.txt
RUN pip install --no-cache-dir -r /usr/src/app/requirements.txt

WORKDIR /data
ENV HOME /data

COPY docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["devpi-server"]

EXPOSE 8000