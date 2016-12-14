#!/bin/sh
# This is the bootstrapping script that provisions Scotch Box for us

cd /home/vagrant

# Needed by Ubuntu 14.04 to get FFMPEG packages (remove this for Ubuntu 16.04) 
add-apt-repository -y ppa:mc3man/trusty-media

# Newer version of ImageMagick on Ubuntu 14.04 (needed for correct webp support)
add-apt-repository -y ppa:jamedjo/ppa

# Repo for PHP 7.0 (for Ubuntu 14.04)
add-apt-repository -y ppa:ondrej/php

# Repo for MariaDB 10.1 (for Ubuntu 14.04)
apt-get install -y software-properties-common
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0xcbcb082a1bb943db
add-apt-repository 'deb [arch=amd64,i386,ppc64el] http://mirrors.accretive-networks.net/mariadb/repo/10.1/ubuntu trusty main'

# Update once after all new repos have been added
apt-get update

# Install packages
apt-get -y install ffmpeg imagemagick pngquant gifsicle webp php7.0 php7.0-mbstring php7.0-mysql php7.0-xml php-apcu

# Switch Apache to PHP 7.0
a2dismod php5
a2enmod php7.0

# To correctly use pecl and other packages, we need a few prerequisites
#apt-get -y install php7.0-dev

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
	wget --quiet https://files.phpmyadmin.net/phpMyAdmin/4.6.3/phpMyAdmin-4.6.3-all-languages.zip
	unzip phpMyAdmin-4.6.3-all-languages.zip
	mv phpMyAdmin-4.6.3-all-languages /vagrant/dev/phpmyadmin
	rm phpMyAdmin-4.6.3-all-languages.zip
fi

# NodeJS CSS dependencies
cd /vagrant/www/ && npm install
npm install -g svgo less clean-css buble rollup uglify-js

cd /home/vagrant

#npm install --prefix /vagrant/www gulp gulp-postcss gulp-sourcemaps autoprefixer cssnano gulp-less stylelint

# Run codebase specific setup scripts
sh /var/www/scripts/setup.sh || true

# Create symlinks to useful folders
#ln -s /var/www www
#ln -s /vagrant/www vvv
ln -s /vagrant/www www
ln -s /vagrant/provision/start_mailcatcher.sh start_mailcatcher.sh
ln -s /etc/php5/apache2/php.ini php.ini
ln -s /etc/php5/apache2/conf.d/user.ini user.ini
ln -s /etc/apache2/apache2.conf apache2.conf
ln -s /etc/mysql/my.cnf mysql.conf
ln -s /etc/redis/6379.conf redis.conf
ln -s /etc/memcached.conf memcached.conf

# TODO: Move this to the code side
ln -s ../../.output/.build/public-ludumdare.com/all.js www/public-ludumdare.com/-/all.js
ln -s ../../.output/.build/public-ludumdare.com/all.css www/public-ludumdare.com/-/all.css
ln -s ../../.output/.build/public-ludumdare.com/all.svg www/public-ludumdare.com/-/all.svg
ln -s ../../.output/.build/public-jammer.vg/all.js www/public-jammer.vg/-/all.js
ln -s ../../.output/.build/public-jammer.vg/all.css www/public-jammer.vg/-/all.css
ln -s ../../.output/.build/public-jammer.vg/all.svg www/public-jammer.vg/-/all.svg
ln -s ../../.output/.build/public-jammer.bio/all.js www/public-jammer.bio/-/all.js
ln -s ../../.output/.build/public-jammer.bio/all.css www/public-jammer.bio/-/all.css
ln -s ../../.output/.build/public-jammer.bio/all.svg www/public-jammer.bio/-/all.svg

# Done
exit
