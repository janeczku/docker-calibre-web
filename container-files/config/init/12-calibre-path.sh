#!/bin/sh
#
# Set the path to Calibre DB folder
#

sed -i "s,^DB_ROOT.*,DB_ROOT = $CALIBRE_PATH," /opt/app/config.ini
echo "Calibre DB folder set to $CALIBRE_PATH"

if [ -f "$CALIBRE_PATH/metadata.db" ]
then
		f=$CALIBRE_PATH
		while [[ $f != "/" ]]; do chmod o+x $f; f=$(dirname $f); done;
		#chmod -R o+rx ${CALIBRE_PATH}
		find ${CALIBRE_PATH} -type d -exec chmod o+rx {} +
        chmod 777 ${CALIBRE_PATH}/metadata.db
        echo "Made calibre metadata.db writable"
fi


