---
title: 1.0 spark src env install..
date: 2022-05-02 12:33:48
categories: [spark]
tags: sparkSQL
---

What's your daily personal growth secret？

<!-- more -->

## 1. IDEA-2021.3.2

## 2. jdk-8u201-macosx-x64

{% codeblock ~/.zprofile lang:bash line_number:true mark:3,5,8 %}
MS=/usr/local/xsoft

JAVA_HOME=$MS/jdk/Contents/Home
JAVA_BIN=$JAVA_HOME/bin
PATH=$JAVA_HOME/bin:$PATH
CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/jre/lib/dt.jar:$JAVA_HOME/jre/lib/tools.jar
export JAVA_HOME JAVA_BIN PATH CLASSPATH
{% endcodeblock %}

```bash
➜ java -version
java version "1.8.0_144"
Java(TM) SE Runtime Environment (build 1.8.0_144-b01)
Java HotSpot(TM) 64-Bit Server VM (build 25.144-b01, mixed mode)
```

## 3. apache-maven

apache-maven-3.8.4-bin.tar.gz

```bash
cd /usr/local/xsoft                   
tar -zxvf apache-maven-3.8.4-bin.tar.gz 
ln -s /usr/local/xsoft/software/apache-maven-3.8.5 maven

vim ~/.zprofile

M2_HOME=/usr/local/xsoft/maven
MAVEN_HOME=$M2_HOME
M3_HOME=$M2_HOME
PATH=$M3_HOME/bin:$PATH
#MAVEN_OPTS="-Xms128m -Xmx512m"
export MAVEN_HOME M2_HOME PATH
```

```bash
mvn -version
Apache Maven 3.8.4 (9b656c72d54e5bacbed989b64718c159fe39b537)
Maven home: /XXX/soft/maven
Java version: 1.8.0_201, vendor: Oracle Corporation, runtime: /Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home
Default locale: zh_CN, platform encoding: UTF-8
OS name: "mac os x", version: "10.16", arch: "x86_64", family: "mac"
```

## 4. spark src-code import

[https://github.com/apache/spark](https://github.com/apache/spark)

## 5. antlr,scala plugin install

装完后重启生效

。。。

## 10. source-code compile

在spark源码包下：

```bash
mvn clean package  -Phive -Phive-thriftserver -Pyarn -DskipTests
```