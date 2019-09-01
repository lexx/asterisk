yum -y update
mcedit /etc/sysconfig/selinux
setenforce 0
cp /usr/share/mc/syntax/sh.syntax /usr/share/mc/syntax/unknown.syntax

mv /etc/localtime /etc/localtime.bak
ln -s /usr/share/zoneinfo/Europe/Samara /etc/localtime
yum -y install chrony
systemctl start chronyd
systemctl enable chronyd
systemctl status chronyd

yum -y install php-pear mc epel-release ncdu net-tools
date
