#!/bin/sh

echo "VM php.ini location:"
echo "/etc/php5/apache2/php.ini"
echo ""

echo "VM Network Info:"
vagrant exec "ifconfig | grep -E 'addr|Link'"
