#!/bin/bash
cd "$(dirname $0)/.."
echo -e "node1\nnode2\nnode3" | xargs -P3 -I {} vagrant up {}
