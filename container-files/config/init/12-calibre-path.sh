#!/bin/sh
#
# Set the path to Calibre DB folder
#

sed -i 's,DB_ROOT.*,DB_ROOT = ${CALIBRE_PATH},' /opt/app/config.ini
#mkdir -p $CALIBRE_PATH
echo "Calibre DB folder set to $CALIBRE_PATH"
