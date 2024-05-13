#!/bin/bash
wget https://www.beegfs.io/release/beegfs_7.4.3/dists/beegfs-jammy.list
sudo mv beegfs-jammy.list /etc/apt/sources.list.d/
wget -q https://www.beegfs.io/release/beegfs_7.4.3/gpg/GPG-KEY-beegfs -O- | sudo apt-key add -
sudo apt-get update
