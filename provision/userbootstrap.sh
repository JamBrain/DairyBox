#!/bin/sh
# This is the bootstrapping script that provisions the vagrant user

NODEJS_VERSION="v16"

echo "\nRunning userbootstrap.sh as unprivileged user \n"

# Report the Host operating system (from inside the VM)
echo "HOST OS: $HOST_OS"
echo "USER : $(whoami)"
cd ~
echo "PWD : $(pwd)"
echo "\n"

# NVM is install for the vagrant user rather than globally.
# This means these commands have to run from the vargant user

# bashrc normally loads nvm but here we have to do it manually
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# install the correct node version and make it the default
nvm install $NODEJS_VERSION > /dev/null 2>&1; #for some inexplicaable reason nvm's download progress bar is on stderr? wtf
nvm alias default $NODEJS_VERSION;

# update npm
npm install --quiet npm -g ;

echo "\n Installing project specific node modules"

cd /vagrant/www/
npm install --quiet

echo "\nFinished userbootstrap.sh\n"
# Done
exit
