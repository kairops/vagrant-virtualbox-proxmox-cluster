#!/bin/bash

# @description Start the pve cluster
#
# @example
#   start
#
# @arg $1 Task: "brief", "help" or "exec"
#
# @exitcode The exit code of the statements of the action
#
# @stdout "Not implemented" message if the requested task is not implemented
#
function start() {

    # Init
    local briefMessage="Cluster start"
    local helpMessage="Start the pve cluster"

    # Task choosing
    case $1 in
        brief)
            showBriefMessage ${FUNCNAME[0]} "$briefMessage"
            ;;
        help)
            showHelpMessage ${FUNCNAME[0]} "$helpMessage"
            ;;
        exec)
            echo "TBD: Cluster start"
            ;;
        *)
            showNotImplemtedMessage $1 ${FUNCNAME[0]}
            return 1
    esac
}

# Main
start "$@"