yum -y update
cp /usr/share/mc/syntax/sh.syntax /usr/share/mc/syntax/unknown.syntax
mcedit /etc/sysconfig/selinux
setenforce 0

mv /etc/localtime /etc/localtime.bak
ln -s /usr/share/zoneinfo/Europe/Samara /etc/localtime
yum install chrony
systemctl start chronyd
systemctl enable chronyd
systemctl status chronyd

yum -y install php-pear wget mc epel-release ncdu
date