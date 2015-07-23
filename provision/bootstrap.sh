#!/bin/sh
# This is the bootstrapping script that provisions Scotch Box for us

cd /home/vagrant

# To correctly use pecl and other packages, we need a few prerequisites
apt-get update
printf "y" | apt-get install php5-dev

# Tell Pear/Pecl packages where to find php.ini
pear config-set php_ini /etc/php5/apache2/php.ini

# Install packages
echo "Installing APCu..."
printf "no\nno" | pecl install APCu-beta

# Run codebase specific setup scripts
sh /var/www/scripts/setup.sh || true

# Done
exit
