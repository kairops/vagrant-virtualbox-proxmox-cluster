# Proxmox Cluster LAB

Build a proxmox 6.0 cluster using Vagrant for testing purposes

## Prerequisites

- Virtualbox installed
- Vagrant installed

## Instructions

1. Clone the repository
2. Execute `bin/vagrantup.sh` script and wait for completion
3. Configure the proxmox cluster following <https://pve.proxmox.com/wiki/Cluster_Manager>

   1. Create the cluster `pvetest` on the first node `node1`

    ```console
    $ vagrant ssh node1 -c "sudo pvecm create pvetest"
    Corosync Cluster Engine Authentication key generator.
    Gathering 2048 bits for key from /dev/urandom.
    Writing corosync key to /etc/corosync/authkey.
    Writing corosync config to /etc/pve/corosync.conf
    Restart corosync and cluster filesystem
    Connection to 127.0.0.1 closed.
    ```

   2. Add the second node `node2` to the cluster (use `vagrant` as password when asked)

    ```console
    $ vagrant ssh node2 -c "sudo pvecm add 10.12.12.101"
    Please enter superuser (root) password for '10.12.12.101':
                                                            Password for root@10.12.12.101: *******
    Establishing API connection with host '10.12.12.101'
    The authenticity of host '10.12.12.101' can't be established.
    X509 SHA256 key fingerprint is 20:02:C9:A8:1F:1E:C0:3B:66:6E:49:36:41:14:C9:CB:2E:4D:E6:D3:DB:A7:E9:BE:70:9B:58:18:32:C7:51:27.
    Are you sure you want to continue connecting (yes/no)? yes
    Login succeeded.
    Request addition of this node
    Join request OK, finishing setup locally
    stopping pve-cluster service
    backup old database to '/var/lib/pve-cluster/backup/config-1565026989.sql.gz'
    waiting for quorum...OK
    (re)generate node files
    generate new node certificate
    merge authorized SSH keys and known hosts
    generated new node certificate, restart pveproxy and pvedaemon services
    successfully added node 'node2' to cluster.
    Connection to 127.0.0.1 closed.
    ```

   3. Add the third node `node3` to the cluster

    ```console
    $ vagrant ssh node3 -c "sudo pvecm add 10.12.12.101"
    Please enter superuser (root) password for '10.12.12.101':
                                                            Password for root@10.12.12.101: *******
    Establishing API connection with host '10.12.12.101'
    The authenticity of host '10.12.12.101' can't be established.
    X509 SHA256 key fingerprint is 20:02:C9:A8:1F:1E:C0:3B:66:6E:49:36:41:14:C9:CB:2E:4D:E6:D3:DB:A7:E9:BE:70:9B:58:18:32:C7:51:27.
    Are you sure you want to continue connecting (yes/no)? yes
    Login succeeded.
    Request addition of this node
    Join request OK, finishing setup locally
    stopping pve-cluster service
    backup old database to '/var/lib/pve-cluster/backup/config-1565027087.sql.gz'
    waiting for quorum...OK
    (re)generate node files
    generate new node certificate
    merge authorized SSH keys and known hosts
    generated new node certificate, restart pveproxy and pvedaemon services
    successfully added node 'node3' to cluster.
    Connection to 127.0.0.1 closed.
    ```

    4. Check the cluster status

    ```console
    $ vagrant ssh node1 -c "sudo pvecm status"
    Quorum information
    ------------------
    Date:             Mon Aug  5 17:46:14 2019
    Quorum provider:  corosync_votequorum
    Nodes:            3
    Node ID:          0x00000001
    Ring ID:          1/12
    Quorate:          Yes

    Votequorum information
    ----------------------
    Expected votes:   3
    Highest expected: 3
    Total votes:      3
    Quorum:           2
    Flags:            Quorate

    Membership information
    ----------------------
        Nodeid      Votes Name
    0x00000001          1 10.12.12.101 (local)
    0x00000002          1 10.12.12.102
    0x00000003          1 10.12.12.103
    Connection to 127.0.0.1 closed.
    ```

4. Access to the nodes with "root" uaser and "vagrant" password

   - Node 1: <https://localhost:18006>
   - Node 2: <https://localhost:28006>
   - Node 3: <https://localhost:38006>

5. Enjoy!

## What do you get

Three virtualbox virtual machines with 512 MB of RAM, 2 CPU's and a second HD with 20 GB each. Proxmox v6.0 will be installed in the virtual machines.

## Troubleshooting

- We use 10.12.12.101 - 103 IP addresses for the virtual machines. Maybe there are in conflict with existent private IP addresses.
- The cluster will not yet configured automatically. Maybe you can make a PR with this issue ;)
