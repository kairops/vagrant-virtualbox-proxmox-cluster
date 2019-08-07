# LXC operation

The isea is to deploy a new LXC container from scratch in each node

## Automatically

Execute the script `bin/lxc_play.sh`

```console
$ bin/lxc_play.sh

[...]
done: SHA256:3ApyP9VgjBzR6k6JImif8zRxuNDviETjYGMjGhJ1IsM root@test103
Creating SSH host key 'ssh_host_rsa_key' - this may take some time ...
done: SHA256:0mwdd03TdkV3KRlRVHUZsCgKVRQ0BrvOdyD6vxcULu4 root@test103
Connection to 127.0.0.1 closed.
┌─────────┬──────┬───────┬────────┬─────────┬───────┬────────┬──────────┬────────────┬────────┬───────┬──────┬─────────┬─────────┬────────┐
│ id      │ type │   cpu │ disk   │ hastate │ level │ maxcpu │  maxdisk │     maxmem │ mem    │ node  │ pool │ status  │ storage │ uptime │
├─────────┼──────┼───────┼────────┼─────────┼───────┼────────┼──────────┼────────────┼────────┼───────┼──────┼─────────┼─────────┼────────┤
│ lxc/101 │ lxc  │ 0.00% │ 0.00 B │         │       │      2 │ 4.00 GiB │ 128.00 MiB │ 0.00 B │ node1 │      │ stopped │         │        │
├─────────┼──────┼───────┼────────┼─────────┼───────┼────────┼──────────┼────────────┼────────┼───────┼──────┼─────────┼─────────┼────────┤
│ lxc/102 │ lxc  │ 0.00% │ 0.00 B │         │       │      2 │ 4.00 GiB │ 128.00 MiB │ 0.00 B │ node2 │      │ stopped │         │        │
├─────────┼──────┼───────┼────────┼─────────┼───────┼────────┼──────────┼────────────┼────────┼───────┼──────┼─────────┼─────────┼────────┤
│ lxc/103 │ lxc  │ 0.00% │ 0.00 B │         │       │      2 │ 4.00 GiB │ 128.00 MiB │ 0.00 B │ node3 │      │ stopped │         │        │
└─────────┴──────┴───────┴────────┴─────────┴───────┴────────┴──────────┴────────────┴────────┴───────┴──────┴─────────┴─────────┴────────┘
Connection to 127.0.0.1 closed.
```

## Manually

### Download template

1. List available LXC templates with `sudo pveam available -section system`

```console
$ vagrant ssh node1 -c "sudo pveam available -section system"
system          alpine-3.10-default_20190626_amd64.tar.xz
system          alpine-3.7-default_20180913_amd64.tar.xz
system          alpine-3.8-default_20180913_amd64.tar.xz
system          alpine-3.9-default_20190224_amd64.tar.xz
system          archlinux-base_20190426-1_amd64.tar.gz
system          centos-6-default_20161207_amd64.tar.xz
system          centos-7-default_20171212_amd64.tar.xz
system          debian-10.0-standard_10.0-1_amd64.tar.gz
system          debian-8.0-standard_8.11-1_amd64.tar.gz
system          debian-9.0-standard_9.7-1_amd64.tar.gz
system          fedora-29-default_20181126_amd64.tar.xz
system          fedora-30-default_20190718_amd64.tar.xz
system          gentoo-current-default_20190718_amd64.tar.xz
system          opensuse-15.0-default_20180907_amd64.tar.xz
system          opensuse-15.1-default_20190719_amd64.tar.xz
system          ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz
system          ubuntu-18.04-standard_18.04.1-1_amd64.tar.gz
system          ubuntu-18.10-standard_18.10-2_amd64.tar.gz
system          ubuntu-19.04-standard_19.04-1_amd64.tar.gz
Connection to 127.0.0.1 closed.
```

2. Download one of the templates on the `local` storage with `sudo pveam download local ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz` in the three nodes

```console
$ vagrant ssh node1 -c "sudo pveam download local ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz"
starting template download from: http://download.proxmox.com/images/system/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz
target file: /var/lib/vz/template/cache/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz
--2019-08-07 16:01:28--  http://download.proxmox.com/images/system/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz
Resolving download.proxmox.com (download.proxmox.com)... 212.224.123.70, 2a01:7e0:0:424::249
Connecting to download.proxmox.com (download.proxmox.com)|212.224.123.70|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 210160363 (200M) [application/octet-stream]
Saving to: '/var/lib/vz/template/cache/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz.tmp.9675'

     0K ........ ........ ........ ........ ........ ........  1% 6.60M 30s
  3072K ........ ........ ........ ........ ........ ........  2% 13.5M 22s

[...]

199680K ........ ........ ........ ........ ........ ........ 98% 42.1M 0s
202752K ........ ........ ........ ........ ......           100% 30.7M=6.7s

2019-08-07 16:01:35 (30.0 MB/s) - '/var/lib/vz/template/cache/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz.tmp.9675' saved [210160363/210160363]

download finished
Connection to 127.0.0.1 closed.
$ vagrant ssh node2 -c "sudo pveam download local ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz"
starting template download from: http://download.proxmox.com/images/system/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz
target file: /var/lib/vz/template/cache/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz
--2019-08-07 16:03:58--  http://download.proxmox.com/images/system/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz
Resolving download.proxmox.com (download.proxmox.com)... 212.224.123.70, 2a01:7e0:0:424::249
Connecting to download.proxmox.com (download.proxmox.com)|212.224.123.70|:80... connected.
HTTP request sent, awaiting response... 200 OK
Length: 210160363 (200M) [application/octet-stream]
Saving to: '/var/lib/vz/template/cache/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz.tmp.6271'

     0K ........ ........ ........ ........ ........ ........  1% 7.68M 26s
  3072K ........ ........ ........ ........ ........ ........  2% 22.3M 17s

[...]

download finished
Connection to 127.0.0.1 closed.
$ vagrant ssh node3 -c "sudo pveam download local ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz"
starting template download from: http://download.proxmox.com/images/system/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz
target file: /var/lib/vz/template/cache/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz
--2019-08-07 16:05:25--  http://download.proxmox.com/images/system/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz
Resolving download.proxmox.com (download.proxmox.com)... 212.224.123.70, 2a01:7e0:0:424::249
Connecting to download.proxmox.com (download.proxmox.com)|212.224.123.70|:80... connected.
HTTP request sent, awaiting response... 200 OK

[...]

download finished
Connection to 127.0.0.1 closed.
```

3. Check if everithing went well with `sudo pveam list local`

```console
$ vagrant ssh node1 -c "sudo pveam list local"
NAME                                                         SIZE  
local:vztmpl/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz    200.42MB
Connection to 127.0.0.1 closed.
MBP-de-Pedro-2:vagrant-virtualbox-proxmox-cluster pedro.rodriguez$ vagrant ssh node2 -c "sudo pveam list local"
NAME                                                         SIZE  
local:vztmpl/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz    200.42MB
Connection to 127.0.0.1 closed.
MBP-de-Pedro-2:vagrant-virtualbox-proxmox-cluster pedro.rodriguez$ vagrant ssh node3 -c "sudo pveam list local"
NAME                                                         SIZE  
local:vztmpl/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz    200.42MB
Connection to 127.0.0.1 closed.
```

### Deploy containers

Creaate one container in each node with `sudo pct create ...`

```console
$ vagrant ssh node1 -c "sudo pct create 101 local:vztmpl/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz -net0 name=eth0,bridge=vmbr0,ip=10.12.12.101/24,gw=10.12.12.1 -memory 128 -hostname test101"
Formatting '/var/lib/vz/images/101/vm-101-disk-0.raw', fmt=raw size=4294967296
mke2fs 1.44.5 (15-Dec-2018)
Discarding device blocks: done                            
Creating filesystem with 1048576 4k blocks and 262144 inodes
Filesystem UUID: 2e314862-7349-4fcb-8d9b-ca06abe8ec0e
Superblock backups stored on blocks: 
	32768, 98304, 163840, 229376, 294912, 819200, 884736

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (16384 blocks): done
Multiple mount protection is enabled with update interval 5 seconds.
Writing superblocks and filesystem accounting information: done 

extracting archive '/var/lib/vz/template/cache/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz'
Total bytes read: 613457920 (586MiB, 93MiB/s)
Detected container architecture: amd64
Creating SSH host key 'ssh_host_ed25519_key' - this may take some time ...
done: SHA256:f5zprF75IEn1h69sKch/lDyrHMA9PccJ4wbbJ1CdRX8 root@test101
Creating SSH host key 'ssh_host_ecdsa_key' - this may take some time ...
done: SHA256:p2ZWl1DFjqjRh9apGHskCAEFRDkOh5dS9x5vlvS+M1M root@test101
Creating SSH host key 'ssh_host_dsa_key' - this may take some time ...
done: SHA256:63eUkehi8Y8peZYQcmizDSSo9JyOUcL1qcGFjUpsHdA root@test101
Creating SSH host key 'ssh_host_rsa_key' - this may take some time ...
done: SHA256:uZLrv2L2LBBn/DFb0hHR/xih1VTFItRB4z1ZdO7gZ9s root@test101
Connection to 127.0.0.1 closed.
$ vagrant ssh node2 -c "sudo pct create 102 local:vztmpl/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz -net0 name=eth0,bridge=vmbr0,ip=10.12.12.102/24,gw=10.12.12.1 -memory 128 -hostname test102"

[...]

$ vagrant ssh node3 -c "sudo pct create 103 local:vztmpl/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz -net0 name=eth0,bridge=vmbr0,ip=10.12.12.103/24,gw=10.12.12.1 -memory 128 -hostname test103"
```

### List all containers

Execute `sudo pvesh get /cluster/resources --type vm` in one of the nodes

```console
$ vagrant ssh node1 -c "sudo pvesh get /cluster/resources --type vm"
┌─────────┬──────┬───────┬────────┬─────────┬───────┬────────┬──────────┬────────────┬────────┬───────┬──────┬─────────┬─────────┬────────┐
│ id      │ type │   cpu │ disk   │ hastate │ level │ maxcpu │  maxdisk │     maxmem │ mem    │ node  │ pool │ status  │ storage │ uptime │
├─────────┼──────┼───────┼────────┼─────────┼───────┼────────┼──────────┼────────────┼────────┼───────┼──────┼─────────┼─────────┼────────┤
│ lxc/101 │ lxc  │ 0.00% │ 0.00 B │         │       │      2 │ 4.00 GiB │ 128.00 MiB │ 0.00 B │ node1 │      │ stopped │         │        │
├─────────┼──────┼───────┼────────┼─────────┼───────┼────────┼──────────┼────────────┼────────┼───────┼──────┼─────────┼─────────┼────────┤
│ lxc/102 │ lxc  │ 0.00% │ 0.00 B │         │       │      2 │ 4.00 GiB │ 128.00 MiB │ 0.00 B │ node2 │      │ stopped │         │        │
├─────────┼──────┼───────┼────────┼─────────┼───────┼────────┼──────────┼────────────┼────────┼───────┼──────┼─────────┼─────────┼────────┤
│ lxc/103 │ lxc  │ 0.00% │ 0.00 B │         │       │      2 │ 4.00 GiB │ 128.00 MiB │ 0.00 B │ node3 │      │ stopped │         │        │
└─────────┴──────┴───────┴────────┴─────────┴───────┴────────┴──────────┴────────────┴────────┴───────┴──────┴─────────┴─────────┴────────┘
Connection to 127.0.0.1 closed.
```
