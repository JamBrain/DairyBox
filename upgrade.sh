#!/bin/bash

# NOTE: This needs to be callable from both the VM and outside

# Upgrade node modules
cd www && npm upgrade
npm upgrade -g

exit $?
