#!/bin/bash

#创建备份目录
mkdir  /backup

#关闭firewalld防火墙服务，并且设置开机不要启动
service firewalld stop
systemctl  disable  firewalld
#临时关闭selinux
setenforce 0
#永久关闭selinux
sed -i '/^SELINUX=/ s/enforcing/disabled/'  /etc/selinux/config

#安装rsync服务端软件
yum install rsync xinetd -y

#设置开机启动
echo '/usr/bin/rsync --daemon --config=/etc/rsyncd.conf' >>/etc/rc.d/rc.local
chmod +x /etc/rc.d/rc.local

#生成/etc/rsyncd.conf配置文件
cat  >/etc/rsyncd.conf  <<EOF
uid = root
gid = root
use chroot = yes
max connections = 0
log file = /var/log/rsyncd.log
pid file = /var/run/rsyncd.pid
lock file = /var/run/rsync.lock
secrets file = /etc/rsync.pass
motd file = /etc/rsyncd.Motd

[back_data]
     path = /backup
     comment = A directory in which data is stored
     ignore errors = yes
     read only = no
     hosts allow = 192.168.98.131
EOF

#创建用户认证文件
cat  >/etc/rsync.pass  <<EOF
slave:123456
EOF

#设置文件所有者读取、写入权限
chmod 600 /etc/rsyncd.conf  
chmod 600 /etc/rsync.pass

#启动rsync
/usr/bin/rsync --daemon --config=/etc/rsyncd.conf
#启动xinetd(xinetd是一个提供保姆服务的进程，rsync是它照顾的进程)
systemctl start xinetd

