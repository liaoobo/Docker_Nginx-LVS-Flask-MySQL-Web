#!/bin/bash

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
log file = /var/log/rsyncd.log
pid file = /var/run/rsyncd.pid
lock file = /var/run/rsync.lock
motd file = /etc/rsyncd.Motd
[Sync]
    comment = Sync
    uid = root
    gid = root
    port= 873
EOF

#启动xinetd(xinetd是一个提供保姆服务的进程，rsync是它照顾的进程)
systemctl start xinetd

#创建认证密码文件，该密码应与slave服务器中的/etc/rsync.pass中的密码一致 
cat  >/etc/passwd.txt  <<EOF
123456
EOF

#设置文件所有者读取、写入权限
chmod 600 /etc/passwd.txt 

