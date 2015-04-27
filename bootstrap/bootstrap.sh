#!/bin/sh
# This is the bootstrapping script run to provision the Vagrant install of Scotch Box.

if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

# To correctly use pecl and other packages, we need a few prerequisites
apt-get update
printf "y" | apt-get install php5-dev

# Install packages
./install-apcu.sh
