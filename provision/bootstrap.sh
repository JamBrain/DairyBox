#!/bin/sh
# This is the bootstrapping script that provisions Scotch Box for us

PHP_VERSION="7.0"
PHP_MYADMIN_VERSION="4.6.3"
MARIADB_VERSION="10.1"
UBUNTU_VERSION="trusty"
NODEJS_VERSION="9.x"

# Report the Host operating system (from inside the VM)
echo "HOST OS: $HOST_OS"

cd /home/vagrant

# Needed by Ubuntu 14.04 to get FFMPEG packages (remove this for Ubuntu 16.04)
add-apt-repository -y ppa:mc3man/trusty-media

# Newer version of ImageMagick on Ubuntu 14.04 (needed for correct webp support)
add-apt-repository -y ppa:jamedjo/ppa

# Repo for current PHP versions
rm /etc/apt/sources.list.d/ondrej-php5-5_6-trusty.list
rm /etc/apt/sources.list.d/ondrej-php5-5_6-trusty.list.save
add-apt-repository -y ppa:ondrej/php

# Repo for MariaDB (for Ubuntu 14.04)
apt-get install -y software-properties-common
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
add-apt-repository "deb [arch=amd64,i386,ppc64el] http://mirrors.accretive-networks.net/mariadb/repo/$MARIADB_VERSION/ubuntu $UBUNTU_VERSION main"

# Repo for Sphinx
add-apt-repository ppa:builds/sphinxsearch-rel22

# Repo for NodeJS (also disable the installed version)
apt-get purge nodejs npm
apt-get autoremove
mv /usr/local/bin/node /usr/local/bin/_node
mv /usr/local/bin/npm /usr/local/bin/_npm
curl -sL https://deb.nodesource.com/setup_$NODEJS_VERSION | sudo -E bash -

# Update once after all new repos have been added
apt-get update

# Install packages
apt-get -y install nodejs ffmpeg imagemagick pngquant gifsicle freeglut3 webp php$PHP_VERSION php$PHP_VERSION-mbstring php$PHP_VERSION-mysql php$PHP_VERSION-xml php$PHP_VERSION-opcache php$PHP_VERSION-gd php$PHP_VERSION-curl php$PHP_VERSION-zip php$PHP_VERSION-redis php-apcu sphinxsearch

# Switch Apache to PHP 7
a2dismod php5
a2enmod php$PHP_VERSION

# Copy old mailcatcher config
cp /etc/php5/apache2/conf.d/20-mailcatcher.ini /etc/php/$PHP_VERSION/apache2/conf.d/

# Copy old php5 user config (disables opcache, enables warnings) - but enable opcache.
sed "s/opcache\.enable.*/opcache.enable = 1/" /etc/php5/apache2/conf.d/user.ini > /tmp/php.edited.user.ini
# Also enable redis, and make it the save handler
echo "extension=redis.so" >> /tmp/php.edited.user.ini
echo "session.save_handler = redis" >> /tmp/php.edited.user.ini
cp /tmp/php.edited.user.ini /etc/php/$PHP_VERSION/apache2/conf.d/user.ini

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

# Mount node_modules for better performance of nodejs.
mkdir -p /vagrant/www/node_modules
mkdir -p /home/vagrant/.node_modules
chown vagrant:vagrant /home/vagrant/.node_modules
mount --bind /home/vagrant/.node_modules /vagrant/www/node_modules

# Install NodeJS packages
sudo -H -u vagrant sh -c 'cd /vagrant/www/; npm install'


cd /home/vagrant

# Create symlinks to useful folders
#ln -s /var/www www
#ln -s /vagrant/www vvv
ln -s /vagrant/www www
ln -s /vagrant/provision/start_mailcatcher.sh start_mailcatcher.sh
ln -s /vagrant/provision/db-create.sh db-create.sh
#ln -s /etc/php5/apache2/php.ini php.ini
#ln -s /etc/php5/apache2/conf.d/user.ini user.ini
ln -s /etc/php/$PHP_VERSION/apache2/php.ini php.ini
ln -s /etc/php/$PHP_VERSION/apache2/conf.d/user.ini user.ini
ln -s /etc/apache2/apache2.conf apache2.conf
ln -s /etc/mysql/my.cnf mysql.conf
ln -s /etc/redis/6379.conf redis.conf
#ln -s /etc/memcached.conf memcached.conf

# Run codebase specific setup scripts
sh /var/www/scripts/setup.sh || true

# Done
exit
