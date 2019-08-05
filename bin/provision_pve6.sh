#!/bin/bash

# Check if the host was already provisioned (first run)
grep -q "# Initial provision" /etc/hosts
if [ $? -eq 0 ]; then
    echo "Already provisioned, skip initial provision"
#    echo "Check pve cluster"
#    pvecm status > /dev/null 2>&1 || (
#        if [ $(hostname) == "node1" ]; then
#            pvecm create pvetest
#        else
#            sleep 60
#            pvecm add node1
#        fi
#    )
    exit 0
fi

# Set /etc/hosts file
echo -e "# Initial provision" >> /etc/hosts
for NODE in 1 2 3; do
    STRHOST="10.12.12.10$NODE node$NODE"
    grep -q "$STRHOST" /etc/hosts || echo $STRHOST >> /etc/hosts
done
sed -i "s/^127.0.1.1/#127.0.1.1/g" /etc/hosts

# Update system
apt update
apt -y full-upgrade

# Set root passwd
echo "root:vagrant"|chpasswd

# Install pve6
echo "deb http://download.proxmox.com/debian/pve buster pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
wget http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg
apt update
DEBIAN_FRONTEND=noninteractive apt -y full-upgrade
DEBIAN_FRONTEND=noninteractive apt install -y proxmox-ve postfix open-iscsi
DEBIAN_FRONTEND=noninteractive apt remove -y os-prober

# Configure ssh
echo "StrictHostKeyChecking no" >> ~/.ssh/config

