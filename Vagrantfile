# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|
    disk = ['./vhd/second_disk_node1.vdi', './vhd/second_disk_node2.vdi','./vhd/second_disk_node3.vdi']
    # Provision node1 + node2 + node3
    (1..3).each do |i|
        config.vm.define :"node#{i}" do |node_conf|
            pveport = (10000 * i) + 8006
            node_conf.vm.box = "debian/buster64"
            node_conf.vm.box_version = "10.0.0"
            node_conf.vm.box_check_update = false
 
            node_conf.vm.network :private_network, ip: "10.12.12.#{i}", virtualbox__intnet: true, auto_config: false
            node_conf.vm.network "forwarded_port", guest: 8006, host: pveport
            node_conf.vm.hostname = "node#{i}"
 
            node_conf.vm.provider 'virtualbox' do |v|
                unless File.exist?(disk[i - 1])
                    v.customize ['createhd', '--filename', disk[i - 1], '--size', 20 * 1024]
                end
                v.customize ['storageattach', :id,  '--storagectl', 'SATA Controller', '--port', 1, '--device', 0, '--type', 'hdd', '--medium', disk [i - 1]]
                v.customize ['modifyvm', :id, '--groups', "/pvetest"]
                v.customize ['modifyvm', :id, '--name', "node#{i}"]
                v.customize ['modifyvm', :id, '--cpus', 2]
                v.customize ['modifyvm', :id, '--memory', 512]
                v.customize ['modifyvm', :id, '--ioapic', 'on']
                v.customize ['modifyvm', :id, '--natdnshostresolver1', 'off']
                v.customize ['modifyvm', :id, '--nictype1', 'virtio']
            end
            node_conf.vm.provision "shell", run: "once", inline: "/vagrant/bin/provision_pve6_node.sh"
            node_conf.vm.provision "shell", run: "once", inline: "reboot"
        end
    end
end
