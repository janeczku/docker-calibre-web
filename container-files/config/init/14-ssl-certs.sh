#!/bin/sh
#
# Apply custom certificate and key
#

DEFAULT_HOST_CONF="/etc/nginx/hosts.d/default.conf"
CERT=${SSL_CERT_NAME:-}
KEY=${SSL_KEY_NAME:-}

if [ ! -z ${CERT} ] && [ ! -z ${KEY} ]; then
	sed -i "s,ssl_certificate\s.*,ssl_certificate /etc/nginx/ssl/$CERT;," DEFAULT_HOST_CONF
	sed -i "s,ssl_certificate_key\s.*,ssl_certificate_key /etc/nginx/ssl/$KEY;," DEFAULT_HOST_CONF
	echo "Set SSL certificate to $CERT"
	echo "Set SSL private key to $KEY"
fi
