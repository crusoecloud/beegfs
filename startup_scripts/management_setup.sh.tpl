#!/bin/bash
apt-get install beegfs-mgmtd -y
/opt/beegfs/sbin/beegfs-setup-mgmtd -p /data/beegfs/beegfs_mgmtd

echo ${connauthkey} > /etc/beegfs/connauthfile
chown root:root /etc/beegfs/connauthfile
chmod 400 /etc/beegfs/connauthfile
sed -i '/^connAuthFile/d' /etc/beegfs/beegfs-mgmtd.conf
echo 'connAuthFile = /etc/beegfs/connauthfile' >> /etc/beegfs/beegfs-mgmtd.conf

systemctl start beegfs-mgmtd
