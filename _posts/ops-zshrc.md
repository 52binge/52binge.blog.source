---
title: My Zsh Config File
toc: true
date: 2017-10-03 20:16:21
categories: devops
tags: macos
description: oh my zsh - zshrc config file
---

my zsh custom config .zshrc file

<!-- more -->

```bash
###################################################
###       blair custom config @2017.10.02       ###
###################################################
alias x='sh $xe'
alias x0='sh $xe0'
alias x8='sh $xe8'

alias hx='source ~/.nvm/nvm.sh'

#alias ll='ls -l'

xe=/usr/local/xsoft/software/com_ssh_machine/libin196.sh
xe0=/usr/local/xsoft/software/com_ssh_machine/libin190.sh
xe8=/usr/local/xsoft/software/com_ssh_machine/libin198.sh

MS=/usr/local/xsoft/software

### JAVA ###
JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk/Contents/Home
JAVA_BIN=$JAVA_HOME/bin
PATH=$JAVA_HOME/bin:$PATH
CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/jre/lib/dt.jar:$JAVA_HOME/jre/lib/tools.jar
export JAVA_HOME JAVA_BIN PATH CLASSPATH

### Maven ###
M2_HOME=/usr/local/xsoft/software/apache-maven
MAVEN_HOME=$M2_HOME
M3_HOME=$M2_HOME
PATH=$M3_HOME/bin:$PATH
export MAVEN_HOME M2_HOME PATH
#MAVEN_OPTS=-Xms128m -Xmx512m

### Tomcat ###
CATALINA_HOME=/usr/local/xsoft/software/apache-tomcat
PATH=$CATALINA_HOME/bin:$PATH
export CATALINA_HOME PATH

### Scala ###
#export SCALA_HOME=/usr/local/xsoft/software/scala
#export SCALA_HOME=/usr/local/Cellar/scala/2.11.5
#export PATH=${SCALA_HOME}/bin:$PATH

### Spark ###
export SPARK_HOME=/usr/local/xsoft/software/spark

### IPython ###
alias ipython='python -m IPython'

### Node.js ###
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm # 这句话可能造成，启动新窗口，速度变慢
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### LANG ###
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
```
