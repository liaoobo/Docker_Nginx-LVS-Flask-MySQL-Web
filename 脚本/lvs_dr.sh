#!/bin/bash
#安装
yum -y install ipvsadm
#手动生成/etc/sysconfig/ipvsadm文件
/usr/sbin/ipvsadm --save > /etc/sysconfig/ipvsadm

# director 服务器上开启路由转发功能
echo 1 > /proc/sys/net/ipv4/ip_forward

#清除防火墙规则
iptables -F
#关闭firewalld防火墙服务，并且设置开机不要启动
service firewalld stop
systemctl  disable  firewalld
#临时关闭selinux
setenforce 0
#永久关闭selinux
sed -i '/^SELINUX=/ s/enforcing/disabled/'  /etc/selinux/config
# 清空lvs里的规则
/usr/sbin/ipvsadm  -C

#添加lvs的虚拟vip规则，此处直接使用keepalived生成的虚拟ip
/usr/sbin/ipvsadm  -A -t 192.168.98.88:80  -s rr
/usr/sbin/ipvsadm  -A -t 192.168.98.99:80  -s rr
#-g 是指定使用DR模式 -w 指定后端服务器的权重值为1  -r 指定后端的real server  -t 是指定vip  -a 追加一个规则 append
/usr/sbin/ipvsadm -a -t 192.168.98.88:80 -r 192.168.98.136:80 -g  -w 1
/usr/sbin/ipvsadm -a -t 192.168.98.88:80 -r 192.168.98.149:80 -g  -w 1
/usr/sbin/ipvsadm -a -t 192.168.98.99:80 -r 192.168.98.136:80 -g  -w 1
/usr/sbin/ipvsadm -a -t 192.168.98.99:80 -r 192.168.98.149:80 -g  -w 1

#保存配置规则
/usr/sbin/ipvsadm -S > /etc/sysconfig/ipvsadm
#启动服务
systemctl start ipvsadm

