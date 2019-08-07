#!/bin/bash

# Check if the host was already provisioned (first run)
grep -q "# Initial provision" /etc/hosts
if [ $? -eq 0 ]; then
    echo "Already provisioned, skip initial provision"
    exit 0
fi

# Configure the second network interface
HOSTNAME=$(hostname)
NODENUMBER=${HOSTNAME:4:1}
echo "
# Bridge
iface eth1 inet manual
auto vmbr0
iface vmbr0 inet static
    address 10.12.12.${NODENUMBER}
    netmask 255.255.255.0
    bridge_ports eth1
    bridge_stp off
    bridge_fd 0

    post-up echo 1 > /proc/sys/net/ipv4/ip_forward
    post-up iptables -t nat -A POSTROUTING -s '10.12.12.0/24' -o eth0 -j MASQUERADE
    post-down iptables -t nat -D POSTROUTING -s '10.12.12.0/24' -o eth0 -j MASQUERADE
    " >> /etc/network/interfaces

# Set /etc/hosts file
echo -e "# Initial provision" >> /etc/hosts
for NODE in 1 2 3; do
    STRHOST="10.12.12.$NODE node$NODE"
    grep -q "$STRHOST" /etc/hosts || echo $STRHOST >> /etc/hosts
done
sed -i "s/^127.0.1.1/#127.0.1.1/g" /etc/hosts

# Update system
apt update
apt -y full-upgrade
apt -y install vim

# Set root passwd
echo "root:vagrant"|chpasswd

# Install pve6
echo "deb http://download.proxmox.com/debian/pve buster pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
wget http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg
apt update
DEBIAN_FRONTEND=noninteractive apt -y full-upgrade
DEBIAN_FRONTEND=noninteractive apt install -y proxmox-ve postfix open-iscsi
DEBIAN_FRONTEND=noninteractive apt remove -y os-prober
