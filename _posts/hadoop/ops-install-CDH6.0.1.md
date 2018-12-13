---
title: 大数据平台CDH6.0集群在线安装
toc: true
date: 2018-11-02 14:16:21
categories: hadoop
tags: CDH
---

介绍了 CDH 集群的搭建与安装

标签： Cloudera-Manager CDH Hadoop 部署 集群

<!-- more -->

> 目前Hadoop比较流行的主要有2个版本，Apache和Cloudera版本。
>
> - Apache Hadoop：维护人员比较多，更新频率比较快，但是稳定性比较差。
> - Cloudera Hadoop（CDH）：CDH：Cloudera公司的发行版本，基于Apache Hadoop的二次开发，优化了组件兼容和交互接口、简化安装配置、增加Cloudera兼容特性。


## 1. 操作环境

- CentOS 7.3 x64 （4C/10G/50G） 
- Cloudera Manager：6.0.1  
- CDH: 6.0.1

相关包地址

Cloudera Manager下载地址：[https://archive.cloudera.com/cm6/6.0.0/redhat7/yum/RPMS/x86_64/](https://archive.cloudera.com/cm6/6.0.0/redhat7/yum/RPMS/x86_64/)

> - cloudera-manager-agent-6.0.0-530873.el7.x86_64.rpm
> - cloudera-manager-daemons-6.0.0-530873.el7.x86_64.rpm
> - cloudera-manager-server-6.0.0-530873.el7.x86_64.rpm
> - cloudera-manager-server-db-2-6.0.0-530873.el7.x86_64.rpm
> - oracle-j2sdk1.8-1.8.0+update141-1.x86_64.rpm

CDH安装包地址：[https://archive.cloudera.com/cdh6/6.0.0/parcels/](https://archive.cloudera.com/cdh6/6.0.0/parcels/)

> - CDH-6.0.0-1.cdh6.0.0.p0.537114-el7.parcel
> - CDH-6.0.0-1.cdh6.0.0.p0.537114-el7.parcel.sha256
> - manifest.json
			   
注意：以下操作均用root用户操作。

## 2. 网络配置(所有节点)

**在所有节点上把IP和主机名的对应关系写入**

```bash
vim /etc/hosts

# 注释掉原有的语句, 增加：
192.192.0.25 server
192.192.0.26 chdagent1
192.192.0.27 chdagent2
```
	  
**在相应的节点主机上修改主机名**

```bash
vim /etc/sysconfig/network

NETWORKING=yes
HOSTNAME=cdhserver

# 修改或者添加 HOSTNAME=cdhserver
```

> cdhserver 是你起的的主机名字

**执行命令**

```
# hostname cdhserver
```

CentOS7要多执行以下这步：

```
hostnamectl set-hostname cdhserver
```

## 3. 打通SSH

设置ssh无密码登陆（所有节点）

## 4. 关闭防火墙和SELinux

注意： 需要在所有的节点上执行，因为涉及到的端口太多了，临时关闭防火墙是为了安装起来更方便，安装完毕后可以根据需要设置防火墙策略，保证集群安全。

关闭防火墙并关闭自启动：

```bash
systemctl stop firewalld
systemctl disable firewalld
```

## 5. 所有节点配置NTP服务

集群中所有主机必须保持时间同步，如果时间相差较大会引起各种问题。 具体思路如下：

master节点作为ntp服务器与外界对时中心同步时间，随后对所有datanode节点提供时间同步服务。

所有datanode节点以master节点为基础同步时间。

所有节点安装相关组件：

```bash
yum install ntp
```

启动服务： 

```bash
systemctl start ntpd
```

配置开机启动：

```bash
systemctl enable ntpd
```

## 6. 安装 python 2.7

必须是python2.7版本，CentOS 7 系统可以不用装，系统自带的。

```
#下载并安装EPEL，安装python-pip，psycopg2有依赖
[root@localhost ~]# wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
[root@localhost ~]# rpm -ivh epel-release-latest-7.noarch.rpm
[root@localhost ~]# yum repolist  #检查是否已添加至源列表
```

升级软件依赖版本

Starting with CDH 6, PostgreSQL-backed Hue requires the Psycopg2 version to be at least 2.5.4

首先安装epel扩展源：

```bash
yum -y install epel-release
yum -y install python-pip
pip install --upgrade psycopg2
```

## 7. 准备Parcels，用以安装CDH6
 
将CHD6相关的Parcel包放到主节点的/opt/cloudera/parcel-repo/目录中，如果没有此目录，可以自己创建。
  
> - CDH-6.0.0-1.cdh6.0.0.p0.537114-el7.parcel
> - CDH-6.0.0-1.cdh6.0.0.p0.537114-el7.parcel.sha256
> - manifest.json

注意：最后将CDH-6.0.0-1.cdh6.0.0.p0.537114-el7.parcel.sha256，重命名为CDH-6.0.0-1.cdh6.0.0.p0.537114-el7.parcel.sha

**安装repo**: 

```bash
wget https://archive.cloudera.com/cm6/6.0.0/redhat7/yum/cloudera-manager.repo -P /etc/yum.repos.d/
```

**导入GPG key**: 

```bash
rpm --import https://archive.cloudera.com/cm6/6.0.0/redhat7/yum/RPM-GPG-KEY-cloudera
```

**JDK install**: 

> yum install oracle-j2sdk1.8
>
> 注意 ： 
> 
>  - 使用 yum 下载，需要确定版本与安装CDH6官方要求的需要的版本一致
>  - 也可不使用 yum 安装，使用自己下载 JDK，然后手动绿色安装配置
>  - 也可在安装 CM 的时候，再根据提示来安装需要的 JDK
> 
> 三种方式任选其一便可

**yum安装CM**: 

```bash
yum install cloudera-manager-server
```

## 8. 安装MySql

```bash
  wget http://repo.mysql.com/mysql-community-release-el7-5.noarch.rpm
  rpm -ivh mysql-community-release-el7-5.noarch.rpm
  yum update
  yum install mysql-server
  systemctl start mysqld
  systemctl enable mysqld
```
  
初始化Mysql

```bash
/usr/bin/mysql_secure_installation
```

配置JDBC

```bash
wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-5.1.46.tar.gz
tar zxvf mysql-connector-java-5.1.46.tar.gz
mkdir -p /usr/share/java/
cd mysql-connector-java-5.1.46
cp mysql-connector-java-5.1.46-bin.jar /usr/share/java/mysql-connector-java.jar
```

建库：根据官方文档提供的命名建库，方便记忆。(在CM配置CDH的时候会用到这些库名)

> Set up the Cloudera Manager Database：/opt/cloudera/cm/schema/scm_prepare_database.sh mysql scm scm

出现如下日志：

```bash
    JAVA_HOME=/usr/java/jdk1.8.0_141-cloudera
    Verifying that we can write to /etc/cloudera-scm-server
    Creating SCM configuration file in /etc/cloudera-scm-server
    Executing:  /usr/java/jdk1.8.0_141-cloudera/bin/java -cp /usr/share/java/mysql-connector-java.jar:/usr/share/java/oracle-connector-java.jar:/usr/share/java/postgresql-connector-java.jar:/opt/cloudera/cm/schema/../lib/* com.cloudera.enterprise.dbutil.DbCommandExecutor /etc/cloudera-scm-server/db.properties com.cloudera.cmf.db.
    [main] DbCommandExecutor INFO  Successfully connected to database.
    All done, your SCM database is configured correctly!
```

## 9. 启动CM服务

启动：

```bash
systemctl start cloudera-scm-server
```
 
查看日志：

```bash
tail -f /var/log/cloudera-scm-server/cloudera-scm-server.log
```

> 出现：INFO WebServerImpl:com.cloudera.server.cmf.WebServerImpl: Started Jetty server.则表示服务正常启动

登录 http://<server_host>:7180 账号：admin



## Reference

- [CDH 6.0.0 搭建][1]
- [CDH6.0.0详细安装教程及所遇到的问题][2]
- [官方文档 - Cloudera Installation Guide][3]

[1]: https://blog.csdn.net/caolijun1166/article/details/82714387
[2]: http://blog.51cto.com/pizibaidu/2174297
[3]: https://www.cloudera.com/documentation/enterprise/6/6.0/topics/installation.html

























































