#!/bin/bash

# Had to use BASH (and not SH, i.e. DASH). arrays ("()") in SH/DASH are unsupported (requires $@ trickery)

argv=("$@")
if [ ! -z "$argv" ]
then 
	args=($(printf "%q " "${argv[@]}"))
fi

vagrant exec "cd ~/www; make ${args[@]}"

exit $?
