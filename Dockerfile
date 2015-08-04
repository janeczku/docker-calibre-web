FROM million12/nginx:latest
MAINTAINER Jan Broer <janeczku@yahoo.de>

ADD container-files /
ADD vendor/kindlegen /opt/app/kindlegen
ADD https://github.com/janeczku/calibre-library/archive/master.zip /tmp/calibre-cps.zip

RUN \
  easy_install gunicorn && \
  mkdir -p /opt/app && \
  unzip /tmp/calibre-cps.zip -d /opt/app && \
  rm /tmp/calibre-cps.zip && \
  chown -R www:www /opt/app

ENV CALIBRE_PATH=/calibre
