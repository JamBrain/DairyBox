#!/bin/sh
# NOTE: This script is separate because something was causing it to execute out-of order.
#       Restarting Apache before I finish installing is dumb. Separating fixed it.

echo "Installing APCu..."
printf "no\nno" | pecl install APCu-beta
echo "extension=apcu.so">>/etc/php5/apache2/php.ini
echo "Added apcu to php.ini. Restarting Apache..."
apache2ctl restart
echo "Done (APCu)."
