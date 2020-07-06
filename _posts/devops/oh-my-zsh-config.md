---
title: My Zsh Config Files
toc: true
date: 2017-10-21 18:16:21
categories: devops
tags: zshrc
---

我的配置文件 **~/.zprofile** 和 **~/.zshrc**

<!-- more -->

## zprofile

```bash
###################################################
###       blair custom config @2020.07.07      ###
###################################################

alias ipython='python -m IPython'

MS=/usr/local/xsoft

### JAVA ###
JAVA_HOME=$MS/jdk/Contents/Home
JAVA_BIN=$JAVA_HOME/bin
PATH=$JAVA_HOME/bin:$PATH
CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/jre/lib/dt.jar:$JAVA_HOME/jre/lib/tools.jar
export JAVA_HOME JAVA_BIN PATH CLASSPATH

export HADOOP_HOME=/usr/local/Cellar/hadoop/3.2.1_1
export HADOOP_COMMON_HOME=$HADOOP_HOME
export PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin

alias start-hp='/usr/local/Cellar/hadoop/3.2.1_1/sbin/start-all.sh'
alias stop-hp='/usr/local/Cellar/hadoop/3.2.1_1/sbin/stop-all.sh'

export SCALA_HOME=/usr/local/Cellar/scala/2.13.3
export PATH=$PATH:$SCALA_HOME/bin

export SPARK_HOME=$MS/spark
export PATH=$PATH:$SPARK_HOME/bin

alias start-sk='/usr/local/xsoft/spark/sbin/start-all.sh'
alias stop-sk='/usr/local/xsoft/spark/sbin/stop-all.sh'

### Maven ###
M2_HOME=/usr/local/xsoft/software/apache-maven
MAVEN_HOME=$M2_HOME
M3_HOME=$M2_HOME
PATH=$M3_HOME/bin:$PATH
#MAVEN_OPTS="-Xms128m -Xmx512m"
export MAVEN_HOME M2_HOME PATH

### Tomcat ###
CATALINA_HOME=/usr/local/xsoft/software/apache-tomcat
PATH=$CATALINA_HOME/bin:$PATH
export CATALINA_HOME PATH

### Node.js ###
export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

### LANG ###
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

### Fast Function ###

# show ip
alias ip='ipconfig getifaddr en0'
alias ip0='ipconfig getifaddr en0'
alias ip1='ipconfig getifaddr en1'

# shutdown
alias shuth='sudo shutdown -h now'
alias shutr='sudo shutdown -r now'

# grep
alias fgstr='find . | xargs grep -ri'
#find .|xargs grep -ri "IBM" 

# pip list
alias pipl='pip list --format=columns'

# lsof -i:port
alias lsofi='lsof -i:'

# hexo
alias hs='cd ~/ghome/blog && hexo clean && hexo s -p 5000 &'
alias hsy='cd ~/ghome/blogyih && hexo clean && hexo s -p 5001 &'

alias cpost='cd ~/ghome/blog/source/_posts'

# deploy blog
alias db='~/ghome/blog && sh dp.sh'
alias dby='cd ~/ghome/blogyih && sh dp.sh'

alias gp='cd ~/ghome/blog/source && git pull && cd ~/ghome/blog/52binge.github.io && git pull && cd .. && clear'
alias gpy='cd ~/ghome/blogyih/source && git pull && cd ~/ghome/blogyih/52binge.github.io && git pull && cd .. && clear'

# Docker
alias dis='docker images'
alias dri='docker rmi'
alias dpa='docker ps -a'
alias dks='docker stop'
alias dck='docker container kill'
alias dcr='docker container rm'
alias dlog='docker logs'

# k8s
alias kb='kubectl'
alias kbg='kubectl get'
alias kbd='kubectl delete'
alias kbgdps='kbg deploy,po,svc'
alias kbdev='export KUBECONFIG=~/kube/dev-kubeconfig'
alias kbtest='export KUBECONFIG=~/kube/test-kubeconfig'

# work

##  download
rqh='rsync -v --progress qh:'
# rsync -v --progress qh:/home/clb/Cyberduck-7.1.0.31395.zip .

##  upload
# rsync -z -P demo.zip qh:/data/Libin/work_project/
alias cpysk="/Users/blair/ghome/github/spark3.0/pyspark"

alias cwk='cd ~/ghome/6E/work_project'
alias csf='cd ~/ghome/6E/self_project'
alias cmlsearch='cd ~/ghome/6E/work_project/mlsearch'
alias cmlar='cd ~/ghome/6E/work_project/mlar'
alias sqh='ssh -L 8889:localhost:8888 -CN qh'
alias sqh-mlsearch='ssh -L 8001:localhost:8001 -CN qh'
alias sqh-mlar='ssh -L 8003:localhost:8003 -CN qh'
alias sqh-mlar-cs='ssh -L 8300:localhost:8300 -CN qh'

alias local_to_es='ssh -L 9200:192.168.x.xxx:9200 -CN onenorth'
alias kibana="ssh -D 1080 -CN onenorth"

alias catma='conda activate mlar'
alias catms='conda activate mlsearch'
alias catnn='conda activate nn_framework'

alias catsk='conda activate spark'
alias cata='conda activate anaconda3'

alias doc='~/ghome/6E/chenlibin/data-doc/source/weekly'

### Pyenv ###
#export PATH="/Users/blair/.pyenv/bin:$PATH"
#alias pyenv_init='eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)"'
#pyenv_init

#export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# ph
alias gitph='vim ~/.oh-my-zsh/plugins/git/git.plugin.zsh'

# zshrc
alias vzp='vim ~/.zprofile'
alias szp='source ~/.zprofile'

#docker run --publish=7474:7474 --publish=7687:7687 --volume=$HOME/neo4j/data:/data neo4j

#pyenv-virtualenv: prompt changing will be removed from future release. configure `export PYENV_VIRTUALENV_DISABLE_PROMPT=1' to simulate the behavior.
```

---
---
---

**以下内容是上一个版本的内容，请忽略...**

---
---
---

## 1. python

```bash
### IPython ###
alias ipython='python -m IPython'

### Pyenv ###
export PATH="/Users/blair/.pyenv/bin:$PATH"
alias pyenv_init='eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)"'
pyenv_init
#export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# pip list
alias pipl='pip list --format=columns'

# pyenv
alias pyenv_install_python_pre='source $MS/custom-machine/pyenv-install.sh'
alias py2='pyenv_init && pyenv activate vpy2 && clear && python -V'
alias py3='pyenv_init && pyenv activate vpy3.5 && clear && python -V'
alias vca3='pyenv activate vconda3 && clear && python -V'
alias pyde='pyenv deactivate'
alias pys='pyenv activate vpy3 && pyenv global system && pyde && python -V'
```

## 2. hexo blog

```bash
# hexo
alias hs='cd ~/ghome/blog && hexo clean && hexo s -p 5000 &'
alias hsy='cd ~/ghome/blogyih && hexo clean && hexo s -p 5001 &'

# deploy blog
alias db='~/ghome/blog && sh dp.sh'
alias dby='~/ghome/blogyih && sh dp.sh'

alias gp='cd ~/ghome/blog/source && git pull && cd ~/ghome/blog/52binge.github.io && git pull && cd .. && clear'
alias gpy='cd ~/ghome/blogyih/source && git pull && cd ~/ghome/blogyih/52binge.github.io && git pull && cd .. && clear'
```

## 3. shortcut approach

```bash
### Fast Function ###

# show ip
alias ip='ipconfig getifaddr en0'
alias ip0='ipconfig getifaddr en0'
alias ip1='ipconfig getifaddr en1'

# shutdown
alias shuth='sudo shutdown -h now'
alias shutr='sudo shutdown -r now'

# grep
alias fgstr='find . | xargs grep -ri'
#find .|xargs grep -ri "IBM" 

# lsof -i:port
alias lsofi='lsof -i:'

# zshrc
alias vzp='vim ~/.zprofile'
alias szp='source ~/.zprofile'

#pyenv-virtualenv: prompt changing will be removed from future release. configure `export PYENV_VIRTUALENV_DISABLE_PROMPT=1' to simulate the behavior.
```

## 4. docker, k8s

```bash
# Docker
alias dis='docker images'
alias dri='docker rmi'
alias dpa='docker ps -a'
alias dks='docker stop'
alias dck='docker container kill'
alias dcr='docker container rm'
alias dlog='docker logs'

# k8s
alias kb='kubectl'
alias kbg='kubectl get'
alias kbd='kubectl delete'
alias kbgdps='kbg deploy,po,svc'
alias kbdev='export KUBECONFIG=~/kube/dev-kubeconfig'
alias kbtest='export KUBECONFIG=~/kube/test-kubeconfig'
```

## 5. work

```bash
# work
alias rqh='rsync -v --progress qh:'

alias cw='cd ~/ghome/6E/work_project'
alias cs='cd ~/ghome/6E/self_project'

alias cmlar='cd ~/ghome/6E/work_project/mlar'

alias sqh='ssh -L 8889:localhost:8888 -CN qh'

alias catm='conda activate mlar'
alias catn='conda activate nn_framework'

alias cata='conda activate anaconda3'

alias doc='~/ghome/6E/chenlibin/data-doc'
```

## 6. node.js

```bash
### Node.js ###
export NVM_DIR="$HOME/.nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
```

## 7. mac env

```bash
### LANG ###
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
```

## 8. Java

```bash
### JAVA ###
JAVA_HOME=/Library/Java/JavaVirtualMachines/Contents/Home
JAVA_BIN=$JAVA_HOME/bin
PATH=$JAVA_HOME/bin:$PATH
CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/jre/lib/dt.jar:$JAVA_HOME/jre/lib/tools.jar
export JAVA_HOME JAVA_BIN PATH CLASSPATH

### Maven ###
M2_HOME=/usr/local/xsoft/software/apache-maven
MAVEN_HOME=$M2_HOME
M3_HOME=$M2_HOME
PATH=$M3_HOME/bin:$PATH
MAVEN_OPTS="-Xms128m -Xmx512m"
export MAVEN_HOME M2_HOME PATH

### Tomcat ###
CATALINA_HOME=/usr/local/xsoft/software/apache-tomcat
PATH=$CATALINA_HOME/bin:$PATH
export CATALINA_HOME PATH
```

## 9. Scala

```bash
### Scala ###
export SCALA_HOME=/usr/local/xsoft/software/scala
export PATH=${SCALA_HOME}/bin:$PATH
#export SCALA_HOME=/usr/local/Cellar/scala/2.11.5

### Kafka
KAFKA_HOME=/usr/local/Cellar/kafka/2.1.0
PATH=$KAFKA_HOME/bin:$PATH
export KAFKA_HOME PATH

### Spark ###
export SPARK_HOME=/usr/local/xsoft/software/spark
export PATH=$SPARK_HOME/bin:$PATH
```

## 10. zshrc

```zsh
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/blair/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
ZSH_THEME="astro" 

plugins=(git)
plugins=(git autojump) # by blair add @2017-10-10
#[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

source $ZSH/oh-my-zsh.sh

```
