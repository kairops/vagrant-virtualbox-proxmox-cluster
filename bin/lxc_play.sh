#!/bin/bash
for number in 1 2 3; do
    vagrant ssh node${number} -c "sudo pveam download local ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz"
    vagrant ssh node${number} -c "sudo pct create 10${number} local:vztmpl/ubuntu-16.04-standard_16.04.5-1_amd64.tar.gz -net0 name=eth0,bridge=vmbr0,ip=10.12.12.10${number}/24,gw=10.12.12.${number} -memory 128 -hostname test10${number}"
done

vagrant ssh node1 -c "sudo pvesh get /cluster/resources --type vm"
