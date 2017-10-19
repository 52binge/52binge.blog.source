---
title: My Zsh Config File
toc: true
date: 2017-10-03 20:16:21
categories: devops
tags: zshrc
---

my zsh custom config .zshrc file

<!-- more -->

```bash

ZSH_THEME="robbyrussell"
ZSH_THEME="astro" 

###################################################
###       blair custom config @2017.10.11       ###
###################################################

alias x='ssh libin@192.168.***.196'
alias x8='ssh libin@192.168.***.198'
alias x0='ssh libin@192.168.***.190'

alias x2='ssh loguser@192.168.***.2'
alias x43='ssh loguser@120.**.**.43'

alias ip='ipconfig getifaddr en0'
alias ip0='ipconfig getifaddr en0'
alias ip1='ipconfig getifaddr en1'

alias sd='ssh-add'
#lsof -i:9001

### hexo
alias hx='source ~/.nvm/nvm.sh'
alias hs='hx && cd ~/ghome/blog && hexo s'

### deploy blog
alias db='hx && cd ~/ghome/blog && hexo clean && sh dp.sh'
alias dg='cd ~/ghome/blog && hexo clean && sh dp.sh'

#alias ll='ls -l'

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
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### LANG ###
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
```
