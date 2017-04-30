#!/bin/sh

vagrant exec "sudo tail /var/log/apache2/error.log"
