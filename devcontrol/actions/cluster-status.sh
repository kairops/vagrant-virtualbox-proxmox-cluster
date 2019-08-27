#!/bin/bash

# @description Display cluster status
#
# @example
#   cluster-status
#
# @arg $1 Task: "brief", "help" or "exec"
#
# @exitcode The exit code of the statements of the action
#
# @stdout "Not implemented" message if the requested task is not implemented
#
function cluster-status() {

    # Init
    local briefMessage="Display cluster status"
    local helpMessage="Use vagrant status over the cluster"

    # Task choosing
    case $1 in
        brief)
            showBriefMessage ${FUNCNAME[0]} "$briefMessage"
            ;;
        help)
            showHelpMessage ${FUNCNAME[0]} "$helpMessage"
            ;;
        exec)
	    cd cluster
	    shift
	    vagrant status $@
            ;;
        *)
            showNotImplemtedMessage $1 ${FUNCNAME[0]}
            return 1
    esac
}

# Main
cluster-status "$@"
