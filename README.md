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
    $ vagrant ssh node2 -c "sudo pvecm add 10.12.12.1"
    Please enter superuser (root) password for '10.12.12.1':
                                                            Password for root@10.12.12.1: *******
    Establishing API connection with host '10.12.12.1'
    The authenticity of host '10.12.12.1' can't be established.
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
    $ vagrant ssh node3 -c "sudo pvecm add 10.12.12.1"
    Please enter superuser (root) password for '10.12.12.1':
                                                            Password for root@10.12.12.1: *******
    Establishing API connection with host '10.12.12.1'
    The authenticity of host '10.12.12.1' can't be established.
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
    0x00000001          1 10.12.12.1 (local)
    0x00000002          1 10.12.12.2
    0x00000003          1 10.12.12.3
    Connection to 127.0.0.1 closed.
    ```

4. Access to the nodes with "root" uaser and "vagrant" password

   - Node 1: <https://localhost:18006>
   - Node 2: <https://localhost:28006>
   - Node 3: <https://localhost:38006>

5. Enjoy!

## What do you get

Three virtualbox virtual machines with 512 MB of RAM, 2 CPU's and a second empty HD with 20 GB in every node. Proxmox v6.0 will be installed in the virtual machines.

You can deploy LXC containers (KVM also if you have nested virtualizaation active) using vmbr0 network and the following gateways:

- 10.12.12.1 within node1
- 10.12.12.2 within node2
- 10.12.12.3 within node3

## Troubleshooting

- The cluster will not be configured automatically yet (maybe you can make a PR with this task), but you can execute the script `bin/configure_pve6_cluster.sh`

```console
$ bin/configure_pve6_cluster.sh
Corosync Cluster Engine Authentication key generator.
Gathering 2048 bits for key from /dev/urandom.
Writing corosync key to /etc/corosync/authkey.
Writing corosync config to /etc/pve/corosync.conf
Restart corosync and cluster filesystem
Connection to 127.0.0.1 closed.
Please enter superuser (root) password for '10.12.12.1':
                                                        Password for root@10.12.12.1: *******
Establishing API connection with host '10.12.12.1'
The authenticity of host '10.12.12.1' can't be established.
X509 SHA256 key fingerprint is D1:DD:F8:69:FF:39:C9:A8:F4:29:0B:58:C1:1D:7A:E1:5F:CD:16:CD:69:52:ED:E7:30:CE:9F:D0:3D:F5:C6:89.
Are you sure you want to continue connecting (yes/no)? yes
Login succeeded.
Request addition of this node
Join request OK, finishing setup locally
stopping pve-cluster service
backup old database to '/var/lib/pve-cluster/backup/config-1565112795.sql.gz'
waiting for quorum...OK
(re)generate node files
generate new node certificate
merge authorized SSH keys and known hosts
generated new node certificate, restart pveproxy and pvedaemon services
successfully added node 'node2' to cluster.
Connection to 127.0.0.1 closed.
Please enter superuser (root) password for '10.12.12.1':
                                                        Password for root@10.12.12.1: *******
Establishing API connection with host '10.12.12.1'
The authenticity of host '10.12.12.1' can't be established.
X509 SHA256 key fingerprint is D1:DD:F8:69:FF:39:C9:A8:F4:29:0B:58:C1:1D:7A:E1:5F:CD:16:CD:69:52:ED:E7:30:CE:9F:D0:3D:F5:C6:89.
Are you sure you want to continue connecting (yes/no)? yes
Login succeeded.
Request addition of this node
Join request OK, finishing setup locally
stopping pve-cluster service
backup old database to '/var/lib/pve-cluster/backup/config-1565112815.sql.gz'
waiting for quorum...OK
(re)generate node files
generate new node certificate
merge authorized SSH keys and known hosts
generated new node certificate, restart pveproxy and pvedaemon services
successfully added node 'node3' to cluster.
Connection to 127.0.0.1 closed.
Quorum information
------------------
Date:             Tue Aug  6 17:33:50 2019
Quorum provider:  corosync_votequorum
Nodes:            3
Node ID:          0x00000001
Ring ID:          1/16
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
0x00000001          1 10.12.12.1 (local)
0x00000002          1 10.12.12.2
0x00000003          1 10.12.12.3
Connection to 127.0.0.1 closed.
```

## Todo

- Mount the PVE cluester automatically
- An automatically configured CEPH cluster
