#!/bin/sh
#
# Set the path to Calibre DB folder
#

sed -i "s,^DB_ROOT.*,DB_ROOT = $CALIBRE_PATH," /opt/app/config.ini
echo "Calibre DB folder set to $CALIBRE_PATH"

sed -i "s,^APP_DB_ROOT.*,APP_DB_ROOT = /data/conf/appdata," /opt/app/config.ini

sed -i "s,^MAIN_DIR.*,MAIN_DIR = /opt/app," /opt/app/config.ini

sed -i "s,^LOG_DIR.*,LOG_DIR = /data/conf/appdata," /opt/app/config.ini

if [ -f "$CALIBRE_PATH/metadata.db" ]
then
        chmod 777 ${CALIBRE_PATH}/metadata.db
        echo "Made calibre metadata.db writable"
fi


