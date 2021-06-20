
---
title: Java SE Learning Notes for Environment
date: 2013-02-02 08:54:16
tags: [java]
categories: java
---

Java 环境的搭建 `手中无剑`, `心中有剑`.

<!-- more -->

## 1. JDK

```bash
MS=/usr/local/xsoft/software

### JAVA ###
JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk/Contents/Home
JAVA_BIN=$JAVA_HOME/bin
PATH=$JAVA_HOME/bin:$PATH
CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/jre/lib/dt.jar:$JAVA_HOME/jre/lib/tools.jar
export JAVA_HOME JAVA_BIN PATH CLASSPATH
```

## 2. Maven

```bash
### Maven ###
M2_HOME=/usr/local/xsoft/software/apache-maven
MAVEN_HOME=$M2_HOME
M3_HOME=$M2_HOME
PATH=$M3_HOME/bin:$PATH
export MAVEN_HOME M2_HOME PATH
#MAVEN_OPTS=-Xms128m -Xmx512m
```

## 3. Tomcat

```bash
### Tomcat ###
CATALINA_HOME=/usr/local/xsoft/software/apache-tomcat
PATH=$CATALINA_HOME/bin:$PATH
export CATALINA_HOME PATH
```

## 4. IDE

- [Intellij IDEA][2]

## Reference

- [Blair Zsh Config][1]

[1]: /2017/10/21/ops-zsh-config/
[2]: https://www.jetbrains.com/idea/
