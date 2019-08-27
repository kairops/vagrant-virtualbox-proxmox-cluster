#!/bin/bash

# create the cluster or add the node to the cluster.
# see https://pve.proxmox.com/wiki/Cluster_Manager
if [ "$(hostname)" == "node1" ]; then
    pvecm create pvetest
else
    expect <<EOF
spawn pvecm add 10.12.12.1
expect -re "Please enter superuser (root) password for .+:"; send "vagrant\\r"
expect "Are you sure you want to continue connecting (yes/no)? "; send "yes\\r"
expect eof
EOF
fi
