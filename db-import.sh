#!/bin/bash

LAST_FILE=$(basename $(ls -1 www/*.sql.gz | tail -n 1))

echo "Importing $LAST_FILE";

vagrant exec "cd ~/www/src/shrub/tools; sudo ./table-load-gzip ../../$LAST_FILE"

