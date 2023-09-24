#!/bin/bash

#在lo接口（loopback）上配置vip
/usr/sbin/ifconfig   lo:0 192.168.98.88  netmask 255.255.255.255  broadcast 192.168.203.188 up
/usr/sbin/ifconfig   lo:1 192.168.98.99  netmask 255.255.255.255  broadcast 192.168.203.199 up
#添加一条主机路由到192.168.203.188/199 走lo:0接口
/sbin/route add -host 192.168.98.88 dev lo:0
/sbin/route add -host 192.168.98.99 dev lo:1

#调整内核参数，关闭arp响应
echo "1" > /proc/sys/net/ipv4/conf/all/arp_ignore
echo "1" > /proc/sys/net/ipv4/conf/lo/arp_ignore 
echo "2" > /proc/sys/net/ipv4/conf/all/arp_announce
echo "2" > /proc/sys/net/ipv4/conf/lo/arp_announce

