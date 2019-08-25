#!/bin/bash

# @description Build the pve cluster
#
# @example
#   build-cluster
#
# @arg $1 Task: "brief", "help" or "exec"
#
# @exitcode The exit code of the statements of the action
#
# @stdout "Not implemented" message if the requested task is not implemented
#
function build-cluster() {

    # Init
    local briefMessage="Cluster build"
    local helpMessage="""Build the pve cluster

    1. Build the 'proxmox-ve-amd64' vagrant box based on the 'debian/buster64' box
    2. Add the 'proxmox-ve-amd64' to the user boxes
    3. Build the pve cluster based on the 'proxmox-ve-amd64'
"""

    # Task choosing
    case $1 in
        brief)
            showBriefMessage ${FUNCNAME[0]} "$briefMessage"
            ;;
        help)
            showHelpMessage ${FUNCNAME[0]} "$helpMessage"
            ;;
        exec)
            echo "TBD: build cluster"
            ;;
        *)
            showNotImplemtedMessage $1 ${FUNCNAME[0]}
            return 1
    esac
}

# Main
build-cluster "$@"