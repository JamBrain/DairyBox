#!/bin/sh
# This is the bootstrapping script run to provision the Vagrant install of Scotch Box.

# To correctly use pecl and other packages, we need a few prerequisites
apt-get update
printf "y" | apt-get install php5-dev

# Install packages
./install-apcu.sh
