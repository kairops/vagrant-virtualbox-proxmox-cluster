#!/bin/bash

# @description Access to the ssh console of one of the cluster nodes
#
# @example
#   cluster-ssh node1
#
# @arg $1 Task: "brief", "help" or "exec"
#
# @exitcode The exit code of the statements of the action
#
# @stdout "Not implemented" message if the requested task is not implemented
#
function cluster-ssh() {

    # Init
    local briefMessage="Cluster node ssh"
    local helpMessage="""Aºccess to one of the cluster node using ssh

Example:

    $ devcontrol cluster-ssh node1

    [...]

    $ devcontrol cluster-ssh node2

    [...]

    $ devcontrol cluster-ssh node3

    [...]
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
	    cd cluster
	    shift
	    vagrant ssh $@
            ;;
        *)
            showNotImplemtedMessage $1 ${FUNCNAME[0]}
            return 1
    esac
}

# Main
cluster-ssh "$@"
