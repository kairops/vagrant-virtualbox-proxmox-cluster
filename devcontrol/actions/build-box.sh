#!/bin/bash

# @description Build the pve6 vagrant box
#
# @example
#   build-box
#
# @arg $1 Task: "brief", "help" or "exec"
#
# @exitcode The exit code of the statements of the action
#
# @stdout "Not implemented" message if the requested task is not implemented
#
function build-box() {

    # Init
    local briefMessage="Build pve6 vagrant box"
    local helpMessage="Build the pve6 vagrant box"

    # Task choosing
    case $1 in
        brief)
            showBriefMessage ${FUNCNAME[0]} "$briefMessage"
            ;;
        help)
            showHelpMessage ${FUNCNAME[0]} "$helpMessage"
            ;;
        exec)
            pushd pve6-box
            vagrant up
            vagrant ssh -c "sudo apt-get clean
            sudo dd if=/dev/zero of=/EMPTY bs=1M
            sudo rm -f /EMPTY
            cat /dev/null > ~/.bash_history
            history -c
            exit"
            rm -f proxmox-ve-amd64.box
            vagrant package --output proxmox-ve-amd64.box
            vagrant box add -f proxmox-ve-amd64 proxmox-ve-amd64.box
            rm -f proxmox-ve-amd64 proxmox-ve-amd64.box
            vagrant destroy -f
            popd 
            ;;
        *)
            showNotImplemtedMessage $1 ${FUNCNAME[0]}
            return 1
    esac
}

# Main
build-box "$@"