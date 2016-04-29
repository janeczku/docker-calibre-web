FROM million12/nginx:latest
MAINTAINER Jan Broer <janeczku@yahoo.de>

RUN \
  # Install ImageMagick & Wand
  rpm --rebuilddb && yum update -y && \
  # Install yum-utils
  #yum install -y yum-utils wget && \
  # Install Imagemagick from Remi YUM repository...
  # rpm -Uvh http://rpms.remirepo.net/enterprise/remi-release-7.rpm && \
  # yum install -y ImageMagick-last-devel
  yum install -y ImageMagick-devel && \
  yum clean all && rm -rf /tmp/yum* && \
  easy_install Wand && \
  # Install Gunicorn
  easy_install gunicorn

ADD container-files /
ADD vendor/kindlegen /opt/app/kindlegen
ADD https://github.com/janeczku/calibre-web/archive/master.tar.gz /tmp/calibre-cps.tar.gz

RUN \
  # Fix locale
  localedef -c -i en_US -f UTF-8 en_US.UTF-8 && \
  # Install calibre-web
  mkdir -p /opt/app && \
  tar zxf /tmp/calibre-cps.tar.gz -C /opt/app --strip-components=1 && \
  rm /tmp/calibre-cps.tar.gz && \
  chown -R www:www /opt/app && \
  mv /opt/app/config.ini.example /opt/app/config.ini && \
  chmod 644 /opt/app/config.ini

ENV CALIBRE_PATH=/calibre ANON_BROWSE=0 PUBLIC_USER_REG=0 ENABLE_UPLOADING=0 LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8 LANGUAGE=en_US:en
