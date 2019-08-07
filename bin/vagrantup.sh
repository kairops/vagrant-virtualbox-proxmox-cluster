#!/bin/bash
cd "$(dirname $0)/.."
BOX=debian/buster64
vagrant box list|grep $BOX || vagrant box add $BOX --provider virtualbox
echo -e "node1\nnode2\nnode3" | xargs -P3 -I {} vagrant up {}
