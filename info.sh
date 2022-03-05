#!/bin/sh

echo "VM Network Info:"
vagrant exec "ifconfig | grep -E 'addr|Link'"

echo "Globals:"
vagrant exec "/vagrant/www/src/shrub/tools/config/config-get"
