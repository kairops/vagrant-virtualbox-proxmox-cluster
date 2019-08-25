#!/bin/bash

# @description Destroy the pve cluster
#
# @example
#   destroy
#
# @arg $1 Task: "brief", "help" or "exec"
#
# @exitcode The exit code of the statements of the action
# @exitcode 1  If the task is not implemented
#
# @stdout "Not implemented" message if the requested task is not implemented
#
function destroy() {

    # Init
    local briefMessage="Cluster removal"
    local helpMessage="Destroy the pve cluster, removing all data and configurations"

    # Task choosing
    case $1 in
        brief)
            showBriefMessage ${FUNCNAME[0]} "$briefMessage"
            ;;
        help)
            showHelpMessage ${FUNCNAME[0]} "$helpMessage"
            ;;
        exec)
            echo "TBD: Cluster removal"
            ;;
        *)
            showNotImplemtedMessage $1 ${FUNCNAME[0]}
            return 1
    esac
}

# Main
destroy "$@"