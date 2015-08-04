#!/bin/sh

#
# This script will be placed in /config/init/ and run when container starts.

set -e

mkdir -p /data/conf/appdata
chmod 777 /data/conf/appdata
chown -R www:www /data/conf/appdata
