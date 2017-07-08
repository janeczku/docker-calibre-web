FROM million12/nginx:latest

RUN \
  # Install ImageMagick & libxml
  rpm --rebuilddb && yum update -y && \
  yum install -y ImageMagick-devel libxml2 libxml2-devel libxml2-python libxslt libxslt-devel python-devel gcc && \
  # Install Gunicorn, Wand
  easy_install Wand && \
  easy_install gunicorn && \
  easy_install lxml && \
  yum remove -y gcc libxslt-devel python-devel libxml2-devel && \
  yum autoremove -y && \
  yum clean all && rm -rf /tmp/yum*

ADD container-files /
ADD vendor/kindlegen /opt/app/vendor/kindlegen

RUN \
  # Fix locale
  localedef -c -i en_US -f UTF-8 en_US.UTF-8 && \
  # Install calibre-web
  mkdir -p /opt/app && \
  curl -L -o /tmp/calibre-cps.tar.gz https://github.com/janeczku/calibre-web/archive/master.tar.gz && \
  tar zxf /tmp/calibre-cps.tar.gz -C /opt/app --strip-components=1 && \
  rm /tmp/calibre-cps.tar.gz && \
  easy_install `cat /opt/app/requirements.txt` && \
  chown -R www:www /opt/app

ENV LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 LANGUAGE=en_US:en
