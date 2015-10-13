#!/bin/sh
#
# Enable/disable public user registration
#

sed -i "s,^PUBLIC_REG.*,PUBLIC_REG = $PUBLIC_USER_REG," /opt/app/config.ini
echo "Public user registration set to $PUBLIC_USER_REG"
