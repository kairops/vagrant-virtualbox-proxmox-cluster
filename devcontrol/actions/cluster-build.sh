#!/bin/bash

# @description Build the pve cluster
#
# @example
#   cluster-build
#
# @arg $1 Task: "brief", "help" or "exec"
#
# @exitcode The exit code of the statements of the action
#
# @stdout "Not implemented" message if the requested task is not implemented
#
function cluster-build() {

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
	    cd cluster
	    vagrant up
            for vm in node1 node2 node3; do
	        vagrant ssh ${vm} -c "sudo /vagrant/provision_pve6_node.sh"
	    done
	    for vm in node1 node2 node3; do
	        vagrant reload ${vm}
	    done
	    for vm in node1 node2 node3; do
	        vagrant ssh ${vm} -c "sudo /vagrant/configure_pve6_cluster.sh"
            done
            ;;
        *)
            showNotImplemtedMessage $1 ${FUNCNAME[0]}
            return 1
    esac
}

# Main
cluster-build "$@"
