#!/bin/sh


LAST_FILE=$(basename $(ls -1 www/*.sql.gz | tail -n 1))

echo "Importing $LAST_FILE";

vagrant exec "cd ~/vvv/scripts/db; sudo ./table-load-gzip ../../$LAST_FILE"

