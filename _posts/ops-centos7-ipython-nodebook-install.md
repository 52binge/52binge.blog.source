---
title: CentOS 7 install spark ipython nodebook
date: 2016-03-11 07:54:16
tags: [ipython]
categories: devops
toc: true
list_number: true
description: centos7 minimal install ipython-nodebook
---

1. IPython notebook 目前已经成为用 Python 做教学、计算、科研的一个重要工具。
2. IPython Notebook 使用浏览器作为界面，向后台的 IPython 服务器发送请求，并显示结果。
3. 在浏览器的界面中使用单元(Cell)保存各种信息。Cell 有多种类型，经常使用的有表示格式化文本的 Markdown单元，和表示代码的 Code单元。

---

本文主要介绍在 centos7 minimal 上安装 ipython-nodebook 流程

## 1. install ifconfig ##

 ```bash
 yum search ifconfig
 yum install net-tools.x86_64
 ```
## 2. install vim ##

 ```bash
 yum search vim
 yum install vim-enhanced
 ```

## 3. install wget ##

 ```bash
 [libin@centos-linux-1 x]$ yum search wget
Loaded plugins: fastestmirror
Loading mirror speeds from cached hostfile
 * base: mirrors.skyshe.cn
 * extras: mirrors.163.com
 * updates: mirrors.163.com
============================================================================================ N/S matched: wget =============================================================================================
wget.x86_64 : A utility for retrieving files using the HTTP or FTP protocols

  Name and summary matches only, use "search all" for everything.
 
 [libin@centos-linux-1 x]$ yum install wget.x86_64
 ```
## 4. install Jdk ##

```bash
# green install jdk-7u80-linux-x64.gz
# edit /etc/profile add
## libin add ##

### JAVA ###
JAVA_HOME=/home/x/jdk
JAVA_BIN=$JAVA_HOME/bin
PATH=$JAVA_HOME/bin:$PATH
CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/jre/lib/dt.jar:$JAVA_HOME/jre/lib/tools.jar
export JAVA_HOME JAVA_BIN PATH CLASSPATH
"/etc/profile" 86L, 2035C

# /etc/profile：该文件是用户登录时，操作系统定制用户环境时使用的第一个文件，应用于登录到系统的每一个用户。 对所有用户有效 ##
```

## 5. install Scala ##

```bash
# green install scala-2.10.4.tgz
# edit /etc/profile add

### Scala ###
#export SCALA_HOME=/usr/local/xSoft/scala
export SCALA_HOME=/home/x/scala
export PATH=${SCALA_HOME}/bin:$PATH
```

## 6. install Spark (Standalone) ##

```bash
green install spark-1.5.2-bin-hadoop2.6.tgz
cp conf/spark-env.sh.template conf/spark-env.sh
```

edit conf/spark-env.sh add

```bash
export JAVA_HOME=/home/x/jdk
export SCALA_HOME=/home/x/scala
export SPARK_HOME=/home/x/spark
export SPARK_MASTER_IP=192.168.181.113
export MASTER=spark://192.168.181.113:7077

export SPARK_EXECUTOR_INSTANCES=2
export SPARK_EXECUTOR_CORES=1

export SPARK_WORKER_MEMORY=1000m
export SPARK_EXECUTOR_MEMORY=300m

export SPARK_LIBRARY_PATH=${SPARK_HOME}/lib

#export SPARK_LAUNCH_WITH_SCALA=0
#export SCALA_LIBRARY_PATH=${SPARK_HOME}/lib


#export SPARK_LIBRARY_PATH=/home/deploy/spark/spark-1.5.2-bin-hadoop2.6/lib
```
## 7. install ipython-nodebook ##

openssh、zlib
```bash
yum -y install openssh-clients
yum install zlib
```

setuptools、pip

```bash
tar xvf setuptools-18.1.tar.gz
cd setuptools-18.1
sudo python setup.py build
sudo python setup.py install

tar xvf pip-8.1.0.tar.gz
cd pip-8.1.0
sudo python setup.py build
sudo python setup.py install
```

ipython、matplotlib

```bash
sudo pip install ipython
sudo pip install matplotlib
```

> mymac : sudo pip install --upgrade ipython --ignore-installed six

python-dev、g++

```bash
sudo yum install python-devel （如果没有安装 python 源代码，会报找不到 Python.h 的头文件错误）
sudo yum install gcc-c++
```

**install python-notebook**

```bash
# 前面install的各种py相关, 为个这一步

sudo pip install notebook
```

## 8. start-up notebook ##

**startup ipython notebook**

```bash
cd your_dir
ipython notebook
```

**startup ipython spark notebook**


```bash
PYSPARK_DRIVER_PYTHON=ipython PYSPARK_DRIVER_PYTHON_OPTS="notebook --ip=192.168.181.113" /home/x/spark/bin/pyspark
```

浏览器访问 http://192.168.181.113:8888/notebooks

![ipython][1]

## 9. spark-notebook example1 ##

```bash
%pylab inline
%matplotlib inline
import numpy as np
import matplotlib.pyplot as plt

data =[33,25,20,12,10]
plt.figure(num=1, figsize=(6,6))
plt.axes(aspect=1)
plt.title('Plot 3', size=14)
plt.pie(data, labels=('Group 1','Group 2','Group 3','Group 4','Group 5'))
plt.savefig('/home/x/spark/test_libin/plot3.png', format='png')
```

![ipython][2]

## maybe attention point ##

```bash
python -V

#若系统默认是python2.6，需要升级到2.7
tar xvf Python-2.7.tgz
./configure --with-zlib=/usr/include --prefix=/usr/local/python27 --prefix=/usr/local/python27

make
make install
mv /usr/bin/python /usr/bin/python_old
ln -s /usr/local/python27/bin/python /usr/bin/
python
此处已经可以正常使用python2.7了
但是因为yum是使用的2.6的版本来用的，所以 还需要修改一下
[root@wangyuelou Python-2.7.2]# vim /usr/bin/yum
#!/usr/bin/python   #修改此处为2.6的位置
```

[1]: /images/ops/ops-ipython-01.png
[2]: /images/ops/ops-ipython-02.png
