#!/bin/sh

echo "VM Network Info:"
vagrant exec "ifconfig | grep -E 'addr|Link'"
