#!/bin/sh
# Internal version of db-create.sh

cd /vagrant/www/src/shrub/tools && ./table-create $@
#sudo sh -c "cd /vagrant/www/src/shrub/tools && ./table-create $@"

exit $?
