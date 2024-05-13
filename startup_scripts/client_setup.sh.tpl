#!/bin/bash
apt-get install beegfs-client -y beegfs-helperd -y
/opt/beegfs/sbin/beegfs-setup-client -m management.${location}.compute.internal

echo ${connauthkey} > /etc/beegfs/connauthfile
chown root:root /etc/beegfs/connauthfile
chmod 400 /etc/beegfs/connauthfile

sed -i '/^connAuthFile/d' /etc/beegfs/beegfs-helperd.conf
echo 'connAuthFile = /etc/beegfs/connauthfile' >> /etc/beegfs/beegfs-helperd.conf

sed -i '/^connAuthFile/d' /etc/beegfs/beegfs-client.conf
echo 'connAuthFile = /etc/beegfs/connauthfile' >> /etc/beegfs/beegfs-client.conf

systemctl start beegfs-helperd
systemctl start beegfs-client

# set automatic replication for storage servers
beegfs-ctl --addmirrorgroup --automatic --nodetype=storage
