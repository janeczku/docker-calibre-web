#!/bin/sh
#
# Apply custom certificate and key
#

DEFAULT_HOST_CONF="/etc/nginx/hosts.d/default.conf"

if [ -n "${SSL_CERT_NAME}" ] && [ -n "${SSL_KEY_NAME}" ]; then
	sed -i "s,ssl_certificate\s.*,ssl_certificate /etc/nginx/ssl/$SSL_CERT_NAME;," DEFAULT_HOST_CONF
	sed -i "s,ssl_certificate_key\s.*,ssl_certificate_key /etc/nginx/ssl/$SSL_KEY_NAME;," DEFAULT_HOST_CONF
	echo "Set SSL certificate to $SSL_CERT_NAME"
	echo "Set SSL private key to $SSL_KEY_NAME"
fi
