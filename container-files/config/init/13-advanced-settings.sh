#!/bin/sh

# Enable public user registration
sed -i "s,^PUBLIC_REG.*,PUBLIC_REG = $PUBLIC_USER_REG," /opt/app/config.ini
echo "Public user registration set to $PUBLIC_USER_REG"

# Enable PDF Upload
sed -i "s,^UPLOADING.*,UPLOADING = $ENABLE_UPLOADING," /opt/app/config.ini
echo "PDF Uploading set to $ENABLE_UPLOADING"
