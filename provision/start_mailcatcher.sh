#!/bin/sh

# Start Mailcatcher
mailcatcher --http-ip=0.0.0.0

echo "Connect to 192.168.48.48:1080 in the browser"

sudo sh -c 'if ! grep -q "sendmail_path=/usr/bin/env" "/etc/php/7.0/apache2/php.ini"; then
  echo "sendmail_path=/usr/bin/env /home/vagrant/.rbenv/shims/catchmail" >> /etc/php/7.0/apache2/php.ini
  service apache2 restart
fi'

# Done
exit
