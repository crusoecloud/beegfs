#!/bin/bash
apt-get install beegfs-storage -y
/opt/beegfs/sbin/beegfs-setup-storage -p /mnt/beegfs_storage -m management.${location}.compute.internal

echo ${connauthkey} > /etc/beegfs/connauthfile
chown root:root /etc/beegfs/connauthfile
chmod 400 /etc/beegfs/connauthfile
sed -i '/^connAuthFile/d' /etc/beegfs/beegfs-storage.conf
echo 'connAuthFile = /etc/beegfs/connauthfile' >> /etc/beegfs/beegfs-storage.conf

systemctl start beegfs-storage
