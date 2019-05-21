#!/bin/sh
# This is the bootstrapping script that provisions Scotch Box for us

PHP_VERSION="7.0"
PHP_MYADMIN_VERSION="4.8.5"
MARIADB_VERSION="10.2"
UBUNTU_VERSION="xenial"

echo "\nRunning bootstrap.sh as privileged user \n"
cd /home/vagrant

# Report the Host operating system (from inside the VM)
echo "HOST OS: $HOST_OS"
echo "USER : $(whoami)"
echo "PWD : $(pwd)"
echo "\n"

# Tell apt that this is not an interactive session so it prompt or wait for input
# dpkg-preconfigure and debconf may be needed to seed valuesif defaults are not okay
export DEBIAN_FRONTEND=noninteractive

# TODO:: is this still needed? what version were we running and what version is it now?
# Newer version of ImageMagick on Ubuntu 14.04 (needed for correct webp support)
#add-apt-repository -y ppa:jamedjo/ppa

# Repo for current PHP versions
#add-apt-repository -y ppa:ondrej/php

#Fix ScotchBox's keys https://github.com/scotch-io/scotch-box/issues/403
wget -qO - https://raw.githubusercontent.com/yarnpkg/releases/gh-pages/debian/pubkey.gpg | sudo apt-key add - #yarn
rm /etc/apt/sources.list.d/mongodb*.list
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list

# Repo for MariaDB https://mariadb.com/kb/en/library/installing-mariadb-deb-files/
apt-get install -y software-properties-common
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xF1656F24C74CD1D8
add-apt-repository "deb [arch=amd64,arm64,ppc64el] http://sfo1.mirrors.digitalocean.com/mariadb/repo/$MARIADB_VERSION/ubuntu $UBUNTU_VERSION main"

# Repo for Sphinx
add-apt-repository ppa:builds/sphinxsearch-rel22

# Update once after all new repos have been added
apt-get -y update


# Install packages
apt-get -y install php$PHP_VERSION php$PHP_VERSION-dev php-redis php-apcu php$PHP_VERSION-mbstring php$PHP_VERSION-mysql php$PHP_VERSION-xml php$PHP_VERSION-opcache php$PHP_VERSION-gd php$PHP_VERSION-curl php$PHP_VERSION-zip
apt-get -y install ffmpeg imagemagick pngquant gifsicle freeglut3 webp sphinxsearch


# TODO:: is this needed? were already using php 7
# Switch Apache to PHP 7
#a2dismod php7.0 #disable existing php module
#a2enmod php$PHP_VERSION

#systemctl restart apache2.service

echo "\nConfiguring PHP"
#sed -i "s/opcache\.enable.*/opcache.enable = 1/" /etc/php/$PHP_VERSION/apache2/conf.d/user.ini
sed -i "s/opache\.enable.*/opcache.enable = 1/" /etc/php/$PHP_VERSION/apache2/conf.d/user.ini # there's a typo :(
sed -i '/mongo.so/d' /etc/php/$PHP_VERSION/apache2/conf.d/user.ini
echo "session.save_handler = redis" >> /etc/php/$PHP_VERSION/apache2/conf.d/user.ini
echo "session.save_path = tcp://127.0.0.1:6379" >> /etc/php/$PHP_VERSION/apache2/conf.d/user.ini

# Tell Pear/Pecl packages where to find php.ini
#pear config-set php_ini /etc/php/$PHP_VERSION/apache2/php.ini

# Install PHP packages
#echo "Installing APCu..."
#printf "no\nno" | pecl install APCu-4.0.11


# Install MariaDB https://mariadb.com/kb/en/library/installing-mariadb-deb-files/
echo "\nInstalling MariaDB"
apt-get install -y mariadb-server-$MARIADB_VERSION galera mariadb-client-$MARIADB_VERSION mariadb-common mariadb-backup-$MARIADB_VERSION
service mysql restart

echo "\nInstalling PHPMyAdmin"
if [ ! -d "/vagrant/dev/phpmyadmin" ]; then
	wget --quiet https://files.phpmyadmin.net/phpMyAdmin/$PHP_MYADMIN_VERSION/phpMyAdmin-$PHP_MYADMIN_VERSION-all-languages.zip
	unzip phpMyAdmin-$PHP_MYADMIN_VERSION-all-languages.zip
	mv phpMyAdmin-$PHP_MYADMIN_VERSION-all-languages /vagrant/dev/phpmyadmin
	rm phpMyAdmin-$PHP_MYADMIN_VERSION-all-languages.zip
fi

echo "\nMounting node_modules" # for better performance of nodejs.
mkdir -p /vagrant/www/node_modules
mkdir -p /home/vagrant/.node_modules
chown vagrant:vagrant /home/vagrant/.node_modules
mount --bind /home/vagrant/.node_modules /vagrant/www/node_modules

echo "\nCreating useful symlinks"
ln -s /vagrant/www www
ln -s /vagrant/provision/db-create.sh db-create.sh
ln -s /etc/php/$PHP_VERSION/apache2/php.ini php.ini
ln -s /etc/php/$PHP_VERSION/apache2/conf.d/user.ini user.ini
ln -s /etc/apache2/apache2.conf apache2.conf
ln -s /etc/mysql/my.cnf mysql.conf
ln -s /etc/redis/redis.conf redis.conf
#ln -s /etc/memcached.conf memcached.conf

# Run codebase specific setup scripts
echo "Running code base specific setup scripts"
sh /var/www/scripts/setup.sh || true

echo "\nFinished bootstrap.sh\n"
# Done
exit
