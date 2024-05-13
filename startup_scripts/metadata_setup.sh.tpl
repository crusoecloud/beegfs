#!/bin/bash
apt-get install beegfs-meta -y
/opt/beegfs/sbin/beegfs-setup-meta -p /data/beegfs/beegfs_meta -m management.${location}.compute.internal

echo ${connauthkey} > /etc/beegfs/connauthfile
chown root:root /etc/beegfs/connauthfile
chmod 400 /etc/beegfs/connauthfile
sed -i '/^connAuthFile/d' /etc/beegfs/beegfs-meta.conf
echo 'connAuthFile = /etc/beegfs/connauthfile' >> /etc/beegfs/beegfs-meta.conf

systemctl start beegfs-meta
