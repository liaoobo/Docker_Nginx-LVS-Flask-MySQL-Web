#!/bin/bash
cd ~
#修改inotify默认参数（inotify默认内核参数值太小）
sysctl -w fs.inotify.max_queued_events="99999999"
sysctl -w fs.inotify.max_user_watches="99999999"
sysctl -w fs.inotify.max_user_instances="65535"

#下载并安装sersync
yum install wget -y
wget http://down.whsir.com/downloads/sersync2.5.4_64bit_binary_stable_final.tar.gz

#解压并改名
tar xf sersync2.5.4_64bit_binary_stable_final.tar.gz
mv /root/GNU-Linux-x86 /usr/local/sersync

#创建rsync
cd /usr/local/sersync/
cp confxml.xml confxml.xml.bak
cp confxml.xml data_configxml.xml   #data_configxml.xml 是后面需要使用的配置文件

#修改data_configxml.xml配置文件
#修改需要备份的路径为/backup
sed -i 's/watch="\/opt\/tongbu"/watch="\/backup"/' /usr/local/sersync/data_configxml.xml
#修改服务器信息为slave4远程备份服务器
sed -i 's/ip="127.0.0.1" name="tongbu1"/ip="192.168.98.146" name="back_data"/' /usr/local/sersync/data_configxml.xml
#开启身份认证，修改密码文件为/etc/passwd.txt
sed -i 's/start="false" users="root" passwordfile="\/etc\/rsync.pas"/start="true" users="root" passwordfile="\/etc\/passwd.txt"/' /usr/local/sersync/data_configxml.xml


#添加到PATH变量
PATH=/usr/local/sersync/:$PATH
echo 'PATH=/usr/local/sersync/:$PATH'  >>/root/.bashrc

#启动
sersync2 -d -r -o  /usr/local/sersync/data_configxml.xml

#设计开机启动
echo '/usr/local/sersync/sersync2 -d -r -o  /usr/local/sersync/data_configxml.xml' >>/etc/rc.local 

