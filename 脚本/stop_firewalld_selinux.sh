#!/bin/bash

#清除防火墙规则
iptables -F
iptables -t nat -F

#关闭防火墙，并设置开机不启动
service firewalld stop
systemctl disable firewalld

#临时禁用selinux
setenforce 0
#永久禁用selinux
sed -i '/^SELINUX=/   s/enforcing/disabled/'  /etc/selinux/config 

