#!/bin/sh
# This is the bootstrapping script that provisions Scotch Box for us

PHP_VERSION="7.0"
PHP_MYADMIN_VERSION="4.6.3"
MARIADB_VERSION="10.1"
UBUNTU_VERSION="trusty"


# Report the Host operating system (from inside the VM)
echo "HOST OS: $HOST_OS"

cd /home/vagrant

# Needed by Ubuntu 14.04 to get FFMPEG packages (remove this for Ubuntu 16.04) 
add-apt-repository -y ppa:mc3man/trusty-media

# Newer version of ImageMagick on Ubuntu 14.04 (needed for correct webp support)
add-apt-repository -y ppa:jamedjo/ppa

# Repo for current PHP versions
add-apt-repository -y ppa:ondrej/php

# Repo for MariaDB (for Ubuntu 14.04)
apt-get install -y software-properties-common
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
add-apt-repository "deb [arch=amd64,i386,ppc64el] http://mirrors.accretive-networks.net/mariadb/repo/$MARIADB_VERSION/ubuntu $UBUNTU_VERSION main"

# Update once after all new repos have been added
apt-get update

# Install packages
apt-get -y install ffmpeg imagemagick pngquant gifsicle webp php$PHP_VERSION php$PHP_VERSION-mbstring php$PHP_VERSION-mysql php$PHP_VERSION-xml php$PHP_VERSION-opcache php$PHP_VERSION-gd php-apcu

# Switch Apache to PHP 7
a2dismod php5
a2enmod php$PHP_VERSION

# Copy old mailcatcher config
cp /etc/php5/apache2/conf.d/20-mailcatcher.ini /etc/php/$PHP_VERSION/apache2/conf.d/

# Copy old php5 user config (disables opcache, enables warnings)
cp /etc/php5/apache2/conf.d/user.ini /etc/php/$PHP_VERSION/apache2/conf.d/

# To correctly use pecl and other packages, we need a few prerequisites
#apt-get -y install php$PHP_VERSION-dev

# Tell Pear/Pecl packages where to find php.ini
#pear config-set php_ini /etc/php5/apache2/php.ini

# Install PHP packages
#echo "Installing APCu..."
#printf "no\nno" | pecl install APCu-4.0.11

# Install MariaDB
apt-get -y remove mysql-server
apt-get -y autoremove
DEBIAN_FRONTEND=noninteractive apt-get -y install mariadb-server

# PHPMyAdmin
if [ ! -d "/vagrant/dev/phpmyadmin" ]; then
	wget --quiet https://files.phpmyadmin.net/phpMyAdmin/$PHP_MYADMIN_VERSION/phpMyAdmin-$PHP_MYADMIN_VERSION-all-languages.zip
	unzip phpMyAdmin-$PHP_MYADMIN_VERSION-all-languages.zip
	mv phpMyAdmin-$PHP_MYADMIN_VERSION-all-languages /vagrant/dev/phpmyadmin
	rm phpMyAdmin-$PHP_MYADMIN_VERSION-all-languages.zip
fi

# NodeJS dependencies
NPM_INSTALL_ARGS=
#if [ -n "$WINDOWS_HOST" ]
#then
#	# NOTE: --no-bin-links doesn't actually help. Run your shell as an administrator instead. Symlinks will work then.
#	NPM_INSTALL_ARGS=--no-bin-links
#fi

cd /vagrant/www/ && npm install $NPM_INSTALL_ARGS
npm install $NPM_INSTALL_ARGS -g svgo less clean-css-cli buble rollup uglify-js eslint


cd /home/vagrant

# Create symlinks to useful folders
#ln -s /var/www www
#ln -s /vagrant/www vvv
ln -s /vagrant/www www
ln -s /vagrant/provision/start_mailcatcher.sh start_mailcatcher.sh
#ln -s /etc/php5/apache2/php.ini php.ini
#ln -s /etc/php5/apache2/conf.d/user.ini user.ini
ln -s /etc/php/$PHP_VERSION/apache2/php.ini php.ini
ln -s /etc/php/$PHP_VERSION/apache2/conf.d/user.ini user.ini
ln -s /etc/apache2/apache2.conf apache2.conf
ln -s /etc/mysql/my.cnf mysql.conf
#ln -s /etc/redis/6379.conf redis.conf
#ln -s /etc/memcached.conf memcached.conf

# Run codebase specific setup scripts
sh /var/www/scripts/setup.sh || true

# Done
exit
