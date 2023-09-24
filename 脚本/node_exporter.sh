#!/bin/bash

#进入root家目录
cd ~
#下载node_exporter源码(由于github无法访问，故省略该步，手动下载)
#curl -O https://github.com/prometheus/node_exporter/releases/download/v1.6.1/node_exporter-1.6.1.linux-amd64.tar.gz
#解压node_exporters源码包
tar xf node_exporter-1.6.1.linux-amd64.tar.gz
#改名
mv  node_exporter-1.6.1.linux-amd64 /node_exporter
cd /node_exporter
#修改PATH环境变量
PATH=/node_exporter:$PATH 
echo "PATH=/node_exporter:$PATH" >>/root/.bashrc
#后台运行，监听8090端口
nohup node_exporter --web.listen-address 0.0.0.0:8090  &
