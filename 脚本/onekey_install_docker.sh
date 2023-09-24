#!/bin/bash

#安装yum-utils工具包
yum install yum-utils -y

#下载docker-ce.repo文件存放在/etc/yum.repos.d
yum-config-manager  --add-repo  https://download.docker.com/linux/centos/docker-ce.repo

#安装docker-ce相关软件
yum install docker-ce docker-ce-cli containerd.io docker-buildx-plugin  docker-compose-plugin  -y

#关闭firewalld防火墙服务，并且设置开机不要启动
service firewalld stop
systemctl  disable  firewalld
#临时关闭selinux
setenforce 0
#永久关闭selinux
sed -i '/^SELINUX=/ s/enforcing/disabled/'  /etc/selinux/config

#启动docker并设计开机启动
systemctl start docker
systemctl enable docker

