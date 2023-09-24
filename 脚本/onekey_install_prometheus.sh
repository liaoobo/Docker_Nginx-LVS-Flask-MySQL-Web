#!/bin/bash

#创建存放prometheus的目录
mkdir /prom

#下载prometheus源码(由于github无法访问，故省略该步，手动下载)
#curl -O https://github.com/prometheus/prometheus/releases/download/v2.47.0/prometheus-2.47.0.linux-amd64.tar.gz

#解压并改名
tar xf ./prometheus-2.47.0.linux-amd64.tar.gz -C /prom
mv /prom/prometheus-2.47.0.linux-amd64 /prom/prometheus

#添加到PATH变量
PATH=/prom/prometheus:$PATH
echo "PATH=/prom/prometheus:$PATH " >>/root/.bashrc

#nohub后台执行启动
nohup prometheus  --config.file=/prom/prometheus/prometheus.yml &

#关闭防火墙
service firewalld stop
systemctl disable firewalld 
