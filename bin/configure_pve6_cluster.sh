#!/bin/bash
cd "$(dirname $0)/.."
vagrant ssh node1 -c "sudo pvecm create pvetest"
vagrant ssh node2 -c "sudo pvecm add 10.12.12.1"
vagrant ssh node3 -c "sudo pvecm add 10.12.12.1"
vagrant ssh node1 -c "sudo pvecm status"
