yum -y update
yum -y install epel-release
yum -y install lynx mariadb-server mariadb php php-mysql php-mbstring tftp-server httpd ncurses-devel sendmail sendmail-cf sox newt-devel libxml2-devel libtiff-devel audiofile-devel gtk2-devel subversion kernel-devel git php-process crontabs cronie cronie-anacron wget vim php-xml uuid-devel sqlite-devel net-tools gnutls-devel php-pear phpmyadmin
pear install Console_Getopt
yum -y groupinstall core base "Development Tools"

firewall-cmd --zone=public --add-port=80/tcp --permanent
firewall-cmd --reload

# Enable MariaDB
systemctl enable mariadb.service

# Start MariaDB
systemctl start mariadb
mysql_secure_installation
systemctl enable httpd.service
systemctl start httpd.service

# Asterisk
adduser asterisk -M -c "Asterisk User"
mkdir /usr/local/etc/asterisk
mkdir /usr/local/share/asterisk
chmod -R 755 /usr/local/etc/asterisk
chown -R asterisk:asterisk /usr/local/etc/asterisk
chown -R asterisk:asterisk /usr/local/share/asterisk
cd /usr/src
wget http://sourceforge.net/projects/lame/files/lame/3.98.4/lame-3.98.4.tar.gz
cd lame-*
tar zxvf lame-3.98.4.tar.gz &&
cd lame-3.98.4 &&
./configure &&
make &&
make install
cd /usr/src
wget http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-15-current.tar.gz
tar xvfz asterisk-15-current.tar.gz
rm -f asterisk-15-current.tar.gz
cd asterisk-*
contrib/scripts/install_prereq install
contrib/scripts/get_mp3_source.sh
./configure --with-pjproject-bundled --with-jansson-bundled
make menuselect
make
make install
make samples
make config
ldconfig
chkconfig asterisk on

# Download Asterisk Sounds
cd /var/lib/asterisk/sounds &&
wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-core-sounds-ru-wav-current.tar.gz &&
wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-extra-sounds-en-wav-current.tar.gz &&
tar xfz asterisk-core-sounds-ru-wav-current.tar.gz &&
rm -f asterisk-core-sounds-ru-wav-current.tar.gz &&
tar xfz asterisk-extra-sounds-en-wav-current.tar.gz &&
rm -f asterisk-extra-sounds-en-wav-current.tar.gz

# Wideband Audio download
wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-core-sounds-ru-g722-current.tar.gz &&
wget http://downloads.asterisk.org/pub/telephony/sounds/asterisk-extra-sounds-en-g722-current.tar.gz &&
tar xfz asterisk-extra-sounds-en-g722-current.tar.gz &&
rm -f asterisk-extra-sounds-en-g722-current.tar.gz &&
tar xfz asterisk-core-sounds-ru-g722-current.tar.gz &&
rm -f asterisk-core-sounds-ru-g722-current.tar.gz

chown asterisk. /var/run/asterisk &&
chown -R asterisk. /etc/asterisk &&
chown -R asterisk. /var/{lib,log,spool}/asterisk &&
chown -R asterisk. /usr/lib/asterisk &&
chown -R asterisk. /var/www/

sed -i 's/\(^upload_max_filesize = \).*/\120M/' /etc/php.ini
sed -i 's/^\(User\|Group\).*/\1 asterisk/' /etc/httpd/conf/httpd.conf
sed -i 's/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf
systemctl restart httpd.service
service asterisk start
