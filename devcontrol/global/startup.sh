#!/bin/bash

# @file devcontrol/global/startup.sh
# @brief devcontrol startup script and functions
echo "Kairops (c) 2019"
echo

# @description Check presence of required packages in the system
# The function aborts the execution if the system dont have the requires packages installed
#
# @example
#   check-pieces
#
# @noargs
#
# @exitcode 0  If all packages exist
# @exitcode 0  If the required packages (vagrant) are missing
#
# @stdout Show an error message if the required packages are not installed
#
function check-packages() {
    which vagrant > /dev/null 2>&1 || bash -c 'echo -e "Missing packages: aborting\You need vagrant"; exit  1'
}
export -f check-packages
