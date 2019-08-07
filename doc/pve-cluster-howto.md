# PVE cluster configuration

Mount a PVE cluster with the name `pvetest`

This task should be executed:

- Just after the `bin/vagrantup.sh`
- Just only one time
- With all the nodes empty of containers

## Automatically

Execute the script `bin/configure_pve6_cluster.sh`

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
X509 SHA256 key fingerprint is 5A:67:02:A2:DF:71:5F:1A:94:2C:65:DB:DD:2A:A2:62:3A:38:D9:22:60:27:A2:06:0E:48:AA:41:39:AA:09:9E.
Are you sure you want to continue connecting (yes/no)? yes
Login succeeded.
Request addition of this node
Join request OK, finishing setup locally
stopping pve-cluster service
backup old database to '/var/lib/pve-cluster/backup/config-1565195101.sql.gz'
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
X509 SHA256 key fingerprint is 5A:67:02:A2:DF:71:5F:1A:94:2C:65:DB:DD:2A:A2:62:3A:38:D9:22:60:27:A2:06:0E:48:AA:41:39:AA:09:9E.
Are you sure you want to continue connecting (yes/no)? yes
Login succeeded.
Request addition of this node
Join request OK, finishing setup locally
stopping pve-cluster service
backup old database to '/var/lib/pve-cluster/backup/config-1565195133.sql.gz'
waiting for quorum...OK
(re)generate node files
generate new node certificate
merge authorized SSH keys and known hosts
generated new node certificate, restart pveproxy and pvedaemon services
successfully added node 'node3' to cluster.
Connection to 127.0.0.1 closed.
Quorum information
------------------
Date:             Wed Aug  7 16:25:51 2019
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

The script will ask you for the root password two times, just when the `node2` and `node3` machines are added to the cluster; you should use `vagrant` as password. Don't forget to answer `yes` when the system ask you to continue connecting.

## Manually

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

