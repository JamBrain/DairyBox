#!/bin/sh
# This is the bootstrapping script that provisions Scotch Box for us

cd /home/vagrant

# Needed by Ubuntu 14.04 to get FFMPEG packages (remove this for Ubuntu 16.04) 
add-apt-repository -y ppa:mc3man/trusty-media

# To correctly use pecl and other packages, we need a few prerequisites
apt-get update
apt-get -y install php5-dev

# Tell Pear/Pecl packages where to find php.ini
pear config-set php_ini /etc/php5/apache2/php.ini

# Install PHP packages
echo "Installing APCu..."
printf "no\nno" | pecl install APCu-4.0.10

# Install other packages
apt-get -y install ffmpeg imagemagick pngquant gifsicle,

# MariaDB
apt-get -y remove mysql-server

apt-get -y install software-properties-common
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
add-apt-repository -y 'deb [arch=amd64,i386] http://nyc2.mirrors.digitalocean.com/mariadb/repo/10.1/ubuntu trusty main'

apt-get update
apt-get -y install mariadb-server

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
