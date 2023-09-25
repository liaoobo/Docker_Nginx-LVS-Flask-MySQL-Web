# 基于Docker_Nginx+LVS+Flask+MySQL的高可用Web集群

## 1.拓扑图

![](https://img-blog.csdnimg.cn/img_convert/31a478612fb9e4f088e9bb3a78d8076e.png)

## 2.详细介绍

项目名称：基于Docker_Nginx+LVS+Flask+MySQL的高可用Web集群

项目环境：centos7.9，docker24.0.5，mysql5.7.30，nginx1.25.2,mysqlrouter8.0.21，keepalived 1.3.5，ansible 2.9.27等

项目描述：模拟一个可扩展、高可用性的企业级 Web 应用架构，集成了多个关键组件以支持大规模的 Web 服务。采用了现代化的docker容器化技术、lvs七层负载均衡、keepalived高可用机制、nginx动静分离及反向代理、 uWSGI和Flask动态Web服务器、MySQL半同步复制、prometheus监控和ansible自动化部署，以确保系统的可靠性、性能和可维护性。

项目步骤：

    1.规划IP配置ansible服务器并建立免密通道，一键安装好软件环境

    2.部署lvs四层负载均衡主从服务器并配置keepalived双vip实现高可用，使用docker配置nginx静态双web服务器启用反向代理实现动静分离

    3.配置flask双动态web服务器并且使用rsync+sersync同步工具部署NFS主从服务器实现动静web界面的数据同源

    4.配置MySQL服务器，安装半同步相关的插件，开启gtid功能，启动主从复制服务，web服务器上使用mysqlrouter中间件实现MySQL的读写分离

    5.搭建DNS域名服务器，配置一个域名对应2个vip，实现基于DNS的负载均衡，访问同一URL解析出双vip地址

    6.使用ab和sysbench对整个MySQL集群的性能进行压力测试，安装部署prometheus实现监控，grafana出图了解系统性能的瓶颈并调优

项目心得：

    1.一定要规划好整个集群的架构，脚本要提前准备好，多注意防火墙和selinux的问题

    2.体验了lvs和nginx负载均衡的区别，领会了docker部署容器的好处

    3.对MySQL的集群和高可用有了深入的理解，对自动化批量部署和监控有了更加多的应用和理解

    4.keepalived的配置需要更加细心，对keepalievd的脑裂和vip漂移现象也有了更加深刻的体会和分析

    5.认识到了系统性能资源的重要性，对压力测试下整个集群的瓶颈有了一个整体概念
