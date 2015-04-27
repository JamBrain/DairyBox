#!/bin/sh

echo "VM php.ini location:"
vagrant exec "php-ini.sh"
#provision/php-ini.sh
echo ""

echo "VM Network Info:"
vagrant exec "ifconfig | grep -E 'addr|Link'"
