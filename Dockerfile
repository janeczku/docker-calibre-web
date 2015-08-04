FROM million12/nginx:latest
MAINTAINER Jan Broer <janeczku@yahoo.de>

ADD container-files /
ADD vendor/kindlegen /opt/app/kindlegen
ADD https://github.com/janeczku/calibre-web/archive/master.tar.gz /tmp/calibre-cps.tar.gz

RUN \
  easy_install gunicorn && \
  mkdir -p /opt/app && \
  tar zxf /tmp/calibre-cps.tar.gz -C /opt/app --strip-components=1 && \
  rm /tmp/calibre-cps.tar.gz && \
  chown -R www:www /opt/app && \
  chmod 644 /opt/app/config.ini

ENV CALIBRE_PATH=/calibre
