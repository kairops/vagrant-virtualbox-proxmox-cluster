# DEPRECATED

Please visit https://github.com/kairops/vagrant-virtualbox-proxmox-cluster

# Proxmox Cluster LAB

Build a proxmox 6.0 cluster using Vagrant for testing purposes

## Prerequisites

- [Virtualbox](https://www.virtualbox.org) installed
- [Vagrant](https://www.vagrantup.com) installed
- [Teecke devcontrol](https://github.com/teecke/devcontrol) installed

## Instructions

1. Clone the repository
2. Execute `devcontrol box-build` and wait for completion. A new vagrant box called "_proxmox-ve-cluster_" will be created.
3. Execute `devcontrol cluster-build` and wait for comnpletion. The pve cluster "pvetest" will be created.
4. Access to the nodes with "root" uaser and "vagrant" password

   - Node 1: <https://localhost:18006>
   - Node 2: <https://localhost:28006>
   - Node 3: <https://localhost:38006>

5. Access to the ssh console of the nodes with

   $ devcontrol cluster-ssh node1
   $ devcontrol cluster-ssh node2
   $ devcontrol cluster-ssh node3

6. Enjoy!

## What do you get

Three virtualbox virtual machines with 512 MB of RAM, 2 CPU's and a second empty HD with 20 GB in every node. Proxmox v6.0 will be installed in the virtual machines.

You can deploy LXC containers (KVM also if you have nested virtualizaation enabled) using vmbr0 network and the following gateways:

- 10.12.12.1 within node1
- 10.12.12.2 within node2
- 10.12.12.3 within node3

## Where to go now

- [Play with LXC containers](doc/lxc-howto.md)

## Todo

- CEPH cluster howto
- ZFS storage howto, w/ replication test
