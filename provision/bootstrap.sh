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
printf "no\nno" | pecl install APCu

# Run codebase specific setup scripts
sh /var/www/scripts/setup.sh || true

# Create symlinks to useful folders
ln -s /var/www www
#ln -s /vagrant vagrant		# disabled, beacuse it confuses vagrant
ln -s /vagrant/www vvv
ln -s /vagrant/provision/start_mailcatcher.sh start_mailcatcher.sh
ln -s /etc/php5/apache2/php.ini php.ini
ln -s /etc/apache2/apache2.conf apache2.conf
ln -s /etc/mysql/my.cnf mysql.conf
ln -s /etc/redis/6379.conf redis.conf
ln -s /etc/memcached.conf memcached.conf

# Done
exit
