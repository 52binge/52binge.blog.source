---
title: 大数据平台CDH集群在线安装
date: 2016-03-14 15:54:16
tags: [cdh]
categories: hadoop
toc: true
list_number: false
---

介绍了 CDH 集群的搭建与安装，其中 Server 安装步骤非常准确, Agent 需要进一步验证.

<!--more-->

标签： Cloudera-Manager CDH Hadoop 部署 集群

> 摘要：管理、部署Hadoop集群需要工具，Cloudera Manager便是其一。本文详细记录了以在线方式部署CDH集群>的步骤。

以Apache Hadoop为主导的大数据技术的出现，使得中小型公司对于大数据的存储与处理也拥有了武器。

目前Hadoop比较流行的主要有2个版本，Apache和Cloudera版本。

Apache Hadoop：维护人员比较多，更新频率比较快，但是稳定性比较差。
Cloudera Hadoop（CDH）：CDH：Cloudera公司的发行版本，基于Apache Hadoop的二次开发，优化了组件兼容和交互接口、简化安装配置、增加Cloudera兼容特性。

```
大数据平台CDH集群 cdh-5.70-rpm_install 详细过程
```

# Part 1 install cdh server #

## 1.1 Ready install resources ##

 1. CentOS Linux release 7.1.1503 (Core) cm-5.7.0 
 2. cloudera-manager-installer.bin
 3. adduser deploy


centos7.1 在安装过程时，网络配置，设置静态IP

```
vim /etc/sysconfig/network-scripts/ifcfg-eth0
```

设置静态ip，以及指定ip地址

```
DEVICE="eth0"
BOOTPROTO="static"
IPADDR=192.168.1.110
NM_CONTROLLED="yes"
ONBOOT="yes"
TYPE="Ethernet"
DNS1=8.8.8.8
DNS2=8.8.4.4
GATEWAY=192.168.1.1
```

## 1.2 网络配置（所有节点）##

**修改hostname为 cdh-server7**

```
　　RedHat 的 hostname，就修改 /etc/sysconfig/network文件，将里面的 HOSTNAME 这一行修改成 HOSTNAME=NEWNAME，其中 NEWNAME 就是你要设置的 hostname。

　　Debian发行版的 hostname 的配置文件是 /etc/hostname
```

**修改ip与主机名的对应关系**

```
[root@cdh-server7 ~]# vi /etc/hosts #修改ip与主机名的对应关系:
192.168.181.190 node190
192.168.181.198 node198
192.168.181.196 node196
```

**重启网络服务生效**

```
[root@cdh-server7 ~]# service network restart
```

**关闭SELINUX**

```
查看SELINUX状态

[root@cdh-server7 ~]#getenforce
```

```
若 SELINUX 没有关闭，按照下述方式关闭

vi /etc/selinux/config
修改SELinux=disabled。重启生效，可以等后面都设置完了重启主机
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#       enforcing - SELinux security policy is enforced.
#       permissive - SELinux prints warnings instead of enforcing.
#       disabled - SELinux is fully disabled.
SELINUX=disabled
# SELINUXTYPE= type of policy in use. Possible values are:
#       targeted - Only targeted network daemons are protected.
#       strict - Full SELinux protection.
SELINUXTYPE=targeted
```

```
[root@cdh-server7 ~]# ping www.baidu.com
```

以上步骤执行完毕后，重启主机

```
reboot
```

重启后再次检查下以上几点，确保环境配置正确。


## 1.3 卸载 openjdk (所有节点)

> 注意 : 如果没有openjdk, 则不需要卸载，默认 centos7 没有

```
[root@cdh-server7 deploy]# rpm -qa | grep java
[root@cdh-server7 deploy]# rpm -qa | grep jdk

# if exist java or jdk, uninstall, erase it.  example under this...
[root@cdh-server7 deploy]# rpm -e --nodeps java-1.5.0-gcj-1.5.0.0-29.1.el6.x86_64
[root@cdh-server7 deploy]# rpm -e --nodeps java-1.6.0-openjdk-1.6.0.0-1.66.1.13.0.el6.x86_64
[root@cdh-server7 deploy]# rpm -e --nodeps java-1.7.0-openjdk-1.7.0.45-2.4.3.3.el6.x86_64
```

## 1.4 卸载 centOS7 默认mysql ##

```
[root@cdh-server7 deploy]# rpm -qa | grep mariadb
[root@cdh-server7 deploy]# rpm -e --nodeps mariadb-libs-5.5.41-2.el7_0.x86_64
```


## 1.5 Cloudera Manager安装 ##

下载资源文件https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/cloudera-manager.repo

将cloudera-manager.repo文件拷贝到所有节点的/etc/yum.repos.d/文件夹下

```
[root@node196 ]# cd /home/deploy/cdh
[root@node196 cdh]# wget https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/cloudera-manager.repo
[root@cdh-server7 cdh]# mv cloudera-manager.repo /etc/yum.repos.d/
```

验证repo文件是否起效

```
yum list|grep cloudera
```

```
[root@cdh-server7 cdh]# yum list | grep cloudera
cloudera-manager-agent.x86_64           5.7.0-1.cm560.p0.54.el7        cloudera-manager
cloudera-manager-daemons.x86_64         5.7.0-1.cm560.p0.54.el7        cloudera-manager
cloudera-manager-server.x86_64          5.7.0-1.cm560.p0.54.el7        cloudera-manager
cloudera-manager-server-db-2.x86_64     5.7.0-1.cm560.p0.54.el7        cloudera-manager
enterprise-debuginfo.x86_64             5.7.0-1.cm560.p0.54.el7        cloudera-manager
oracle-j2sdk1.7.x86_64                  1.7.0+update67-1               cloudera-manager
```

如果列出的不是你安装的版本，执行下面命令重试

```
yum clean all 
yum list | grep cloudera
```

上传下列 **rpm 包** 到 [root@cdh-server7] 的 /home/deploy/cdh/cloudera-rpms (任意目录)

```
cd /home/deploy/cdh/cloudera-rpms
cloudera-manager-agent-5.7.0-1.cm560.p0.54.el7.x86_64.rpm
cloudera-manager-daemons-5.7.0-1.cm560.p0.54.el7.x86_64.rpm
cloudera-manager-server-5.7.0-1.cm560.p0.54.el7.x86_64.rpm   ## agent not use
cloudera-manager-server-db-2-5.7.0-1.cm560.p0.54.el7.x86_64.rpm  ## agent not use
enterprise-debuginfo-5.7.0-1.cm560.p0.54.el7.x86_64.rpm
oracle-j2sdk1.7-1.7.0+update67-1.x86_64.rpm
```

> 说明 : 可从https://archive.cloudera.com/cm5/redhat/7/x86_64/cm/5/RPMS/x86_64/ 下载相关rpm包

切换到rpms目录下，执行

```
[root@cdh-server7 cdh]# cd /home/deploy/cdh/cloudera-rpms/
[root@cdh-server7 cloudera-rpms]# yum -y install *.rpm
```

## 1.6 拷贝资源包到目标目录 ##

```
从 http://archive.cloudera.com/cdh5/parcels/5.7.0/ 下载资源包
```

将之前下载的Parcel那3个文件拷贝到/opt/cloudera/parcel-repo目录下（如果没有该目录，请自行创建）

```
[root@cdh-server7 cdh]# cp CDH-5.7.0-1.cdh5.7.0.p0.45-el7.parcel /opt/cloudera/parcel-repo/CDH-5.7.0-1.cdh5.7.0.p0.45-el7.parcel
[root@cdh-server7 cdh]# cp CDH-5.7.0-1.cdh5.7.0.p0.45-el7.parcel.sha1 /opt/cloudera/parcel-repo/CDH-5.7.0-1.cdh5.7.0.p0.45-el7.parcel.sha
[root@cdh-server7 cdh]# cp manifest.json /opt/cloudera/parcel-repo/manifest.json
```

## 1.7 配置 java 环境变量

设置JAVA_HOME

```
[root@cdh-server7 cdh]#vi /etc/profile
export JAVA_HOME=/usr/java/jdk1.7.0_67-cloudera/
export PATH=$JAVA_HOME/bin:$PATH
[root@cdh-server7 cdh]#source /etc/profile
```

关闭防火墙

```
[root@cdh-server7 deploy]#systemctl stop firewalld.service  #centos7,关闭防火墙
```

以上步骤执行完毕后，重启主机

```
reboot
```

## 1.8 安装CM (只在主节点)

**以下两步骤请只在主节点上执行 :**

- 进入该目录，给bin文件赋予可执行权限

  ```
  [root@cdh-server7 cdh]# chmod a+x ./cloudera-manager-installer.bin
  ```

- 安装CM (该步骤, 可能是不需要的)

  ```
  [root@cdh-server7 cdh]# ./cloudera-manager-installer.bin
  ```

**开始启动server端**

```
[root@cdh-server7 cdh]# cd /etc/init.d/
[root@cdh-server7 init.d]# ./cloudera-scm-server-db start

[root@cdh-server7 init.d]# ./cloudera-scm-server start
Starting cloudera-scm-server:                              [  OK  ]
[root@cdh-server7 init.d]# tail -f /var/log/cloudera-scm-server/cloudera-scm-server.log
```

>注意 : 
>  机器重启之后，默认启动会导致异常
>  需要按照该先启动cloudera-scm-server-db，再启动cloudera-scm-server的顺序执行

## 1.9 浏览器访问验证(主节点) ##

CM安装成功后浏览器输入http://ip:7180, 用户名和密码都输入admin，进入web管理界面。

通过浏览器访问验证

```
http://192.168.181.190:7180/
```

如果打不开改网页，等待2分钟后。这个服务启动是需要一定时间的。

选择部署的版本，这里我们选择免费版的就可以了。

> 如果不会设置，那么请参考 最靠谱的安装指南 http://www.jianshu.com/p/57179e03795f

安装服务时，数据库选择默认的嵌入式数据库


# Part 2 安装 agent #

> this step is similar， but I can't be sure, exactly right. 

```
安装 agent ，可以在单独的机器，主节点，可以只当做主，随意你
```

> 为agent做配置,启动agent (所有节点)
> agent 不需要装server，其他绝大部分步骤和 安装 server 相同。

## 2.1 网络配置

**修改ip与主机名的对应关系**

```
[root@cdh-agent1 ~]# vi /etc/hosts #修改ip与主机名的对应关系:
192.168.181.190 cdh-server7(node190)
192.168.181.198 cdh-agent1(node198)
192.168.181.196 cdh-agent2(node196)
```
**重启网络服务生效**

```
[root@cdh-server7 ~]# service network restart
```

**关闭SELINUX**

```
查看SELINUX状态

[root@cdh-server7 ~]#getenforce
```

```
若 SELINUX 没有关闭，按照下述方式关闭

vi /etc/selinux/config
修改SELinux=disabled。重启生效，可以等后面都设置完了重启主机
# This file controls the state of SELinux on the system.
# SELINUX= can take one of these three values:
#       enforcing - SELinux security policy is enforced.
#       permissive - SELinux prints warnings instead of enforcing.
#       disabled - SELinux is fully disabled.
SELINUX=disabled
# SELINUXTYPE= type of policy in use. Possible values are:
#       targeted - Only targeted network daemons are protected.
#       strict - Full SELinux protection.
SELINUXTYPE=targeted
```

```
[root@cdh-server7 ~]# ping www.baidu.com
```

## 2.2 卸载 openjdk (所有节点)##

> 注意 : 如果没有openjdk, 则不需要卸载，默认 centos7 没有

```
[root@cdh-server7 deploy]# rpm -qa | grep java
[root@cdh-server7 deploy]# rpm -qa | grep jdk

# if exist java or jdk, uninstall, erase it.  example under this...
[root@cdh-server7 deploy]# rpm -e --nodeps java-1.5.0-gcj-1.5.0.0-29.1.el6.x86_64
[root@cdh-server7 deploy]# rpm -e --nodeps java-1.6.0-openjdk-1.6.0.0-1.66.1.13.0.el6.x86_64
[root@cdh-server7 deploy]# rpm -e --nodeps java-1.7.0-openjdk-1.7.0.45-2.4.3.3.el6.x86_64
```

## 2.3 卸载centOS7默认mysql

```
[root@cdh-server7 deploy]# rpm -qa | grep mariadb
[root@cdh-server7 deploy]# rpm -e --nodeps mariadb-libs-5.5.41-2.el7_0.x86_64
```

## 2.4 cloudera-manager.repo

> 上传cloudera-manager.repo 到 cdh-agent1

[root@cdh-agent1 cdh]# cp cloudera-manager.repo /etc/yum.repos.d/

**transparent_hugepage**

```
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo never > /sys/kernel/mm/transparent_hugepage/defrag
```

**vi /etc/rc.local 在文件尾放入 如下两条语句**

```
echo never > /sys/kernel/mm/transparent_hugepage/enabled
echo never > /sys/kernel/mm/transparent_hugepage/defrag
```

```
chmod +x /etc/rc.local
```

**调整swappiness**

```
echo 10 > /proc/sys/vm/swappiness
# vi /etc/sysctl.conf
vm.swappiness = 10
```

## 2.5 ~/cdh/cloudera-rpms

> 上传下列rpm包到cdh-agent1的/home/deploy/cdh/cloudera-rpms

```
cloudera-manager-agent-5.7.0-1.cm560.p0.54.el7.x86_64.rpm
cloudera-manager-daemons-5.7.0-1.cm560.p0.54.el7.x86_64.rpm
enterprise-debuginfo-5.7.0-1.cm560.p0.54.el7.x86_64.rpm
oracle-j2sdk1.7-1.7.0+update67-1.x86_64.rpm

[root@cdh-agent1 init.d]# cd /home/deploy/cdh/cloudera-rpms/
[root@cdh-agent1 init.d]# yum -y install *.rpm
```

**设置JAVA_HOME**

```
[root@cdh-server7 cdh]#vi /etc/profile
export JAVA_HOME=/usr/java/jdk1.7.0_67-cloudera/
export PATH=$JAVA_HOME/bin:$PATH
[root@cdh-server7 cdh]#source /etc/profile
```

关闭防火墙

```
[root@cdh-server7 deploy]#systemctl stop firewalld.service  #centos7,关闭防火墙
```

以上步骤执行完毕后，重启主机

```
reboot
```

```
[root@cdh-agent1 init.d]# vi /etc/cloudera-scm-agent/config.ini

+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
# Hostname of the CM server.
#server_host=localhost
server_host=cdh-server7(node190)
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
```

```
[root@cdh-server7 cdh]# cd /etc/init.d/
[root@cdh-server7 init.d]# ./cloudera-scm-agent start
Starting cloudera-scm-agent:                               [  OK  ]
[root@cdh-server deploy]# tail -f /var/log//cloudera-scm-agent/cloudera-scm-agent.log
```

------

注意 : 

```
安装YARN NodeManager失败时，需要删除 /yarn /var/lib/hadoop-yarn 目录再重新添加
```

------

CDH最靠谱的安装指南 : http://www.jianshu.com/p/57179e03795f


# Part 3 恢复启动 Our 集群 #

## 3.1 确定 firewalld close

```
systemctl start firewalld.service#启动firewall
systemctl stop firewalld.service#停止firewall
systemctl disable firewalld.service#禁止firewall开机启动
```

> 注意 : 操作之前确定 firewalld 是关闭的


```
[root@node19x flag]$ vim /etc/rc.local (/etc/rc.local 对应貌似相对dir /ect/init.d)

  1 #!/bin/bash
  2 # THIS FILE IS ADDED FOR COMPATIBILITY PURPOSES
  3 #
  4 # It is highly advisable to create own systemd services or udev rules
  5 # to run scripts during boot instead of using this file.
  6 #
  7 # In contrast to previous versions due to parallel execution during boot
  8 # this script will NOT be run after all other services.
  9 #
 10 # Please note that you must run 'chmod +x /etc/rc.d/rc.local' to ensure
 11 # that this script will be executed during boot.
 12
 13 touch /var/lock/subsys/local
 14 echo never > /sys/kernel/mm/transparent_hugepage/enabled
 15 echo never > /sys/kernel/mm/transparent_hugepage/defrag
 16 service ntpd start
 17 service elasticsearch start
```

## 3.2 启动server端、cm

only at server node

```
[root@cdh-server7 cdh]# cd /etc/init.d/
[root@cdh-server7 init.d]# ./cloudera-scm-server-db start

[root@cdh-server7 init.d]# ./cloudera-scm-server start
Starting cloudera-scm-server:                              [  OK  ]
[root@cdh-server7 init.d]# tail -f /var/log/cloudera-scm-server/cloudera-scm-server.log

// 等待日志 7180 启动成功， 访问 : http://node190:7180/cmf/home
```

>注意 : 
>机器重启之后，默认启动会导致异常
>需要按照该先启动cloudera-scm-server-db，再启动cloudera-scm-server的顺序执行


一般以下 agent 是自动启动的

```
[root@node190 init.d]# ./cloudera-scm-agent start
cloudera-scm-agent is already running
node190:./cloudera-scm-agent start
node19x:./cloudera-scm-agent start
node19x:./cloudera-scm-agent start
...
```

## 3.3 CM页面上启动各服务

 1. CM 页面上重启 service monitor
 2. CM 页面上重启 host monitor
 3. CM 页面上启动各项服务 (如 : ZK, Flume, YARN, HDFS, Hive, Sqoop, Spark etc..)

---

## 3.4 各个节点启动 ES

```
[deploy@node190 init.d]# ll
total 44
-rwxr-xr-x  1 root root  8671 Apr  2 04:52 cloudera-scm-agent
lrwxrwxrwx. 1 root root    58 Apr 18 16:55 elasticsearch -> /home/deploy/elasticsearch-1.7.1/bin/service/elasticsearch
-rw-r--r--. 1 root root 13948 Sep 16  2015 functions
-rwxr-xr-x. 1 root root  2989 Sep 16  2015 netconsole
-rwxr-xr-x. 1 root root  6630 Sep 16  2015 network
-rw-r--r--. 1 root root  1160 Apr  1 00:45 README
```

**deploy**

```bash
cd /home/deploy/elasticsearch-1.7.1/bin/service
[deploy@node190 init.d]# ./elasticsearch start
[deploy@node19x init.d]# ./elasticsearch start
[deploy@node19x init.d]# ./elasticsearch start
...
```

```
http://node190:9200/_plugin/bigdesk/#cluster
```

> 等待同步数据完成，一般会很快，等待 Status 从 RED 变为 green 状态

```
http://node190:9200/_plugin/head/
```

## 3.5 启动 kibana

```
[deploy@node196 ~]#
cd /home/deploy/kibana-4.1.1-linux-x64
    ./bin/kibana > kibana.log 2>&1 &              --@deploy
```
