---
title: linux etc/profile and zshrc 等环境配置简介
date: 2014-05-18 07:54:16
tags: [bashrc]
categories: devops
toc: true
list_number: true
description: linux /etc/profile、.zshrc 等环境配置简介
---


config file | desc
------- | -------
/etc/profile，/etc/bashrc | 系统全局环境变量设定
~/.profile，~/.bashrc | 用户家目录下的私有环境变量设定 
 
## 1. login env steps

> 以下是 登入系统,环境设定档 流程

Read step | desc
------- | -------
/etc/profile | /etc/profile.d 和 /etc/inputrc 。 从/etc/profile.d目录的配置文件搜集shell的设置
~/.bash_profile | ~/.bash_profile，如无则读取 ~/.bash_login，如无则读取 ~/.profile
~/.bashrc | ~/.bashrc (交互式 non-login 方式进入 bash 运行的)

## 2. ~/.profile and ~/.bashrc

~/.profile 、 ~/.bashrc 相同点 |
------- | -------
都具有个性化定制功能 | 
~/.profile 可以设定本用户专有的路径，环境变量，等，它只能登入的时候执行一次 |
~/.bashrc 也是某用户专有设定文档，可以设定路径，命令别名，每次shell script的执行都会使用它一次 |

bashrc 和 profile 的区别 |
------- | -------
`交互式模式` : shell等待你的输入，并且执行你提交的命令。 shell与用户进行交互 登录、执行命令、签退、shell终止 | 
`非交互式模式` : shell不与你进行交互，是读取存在文件中的命令,并且执行它们。当它读到文件的结尾，shell终止 |

> ~/.bash_profile 是交互式、login 方式进入 bash 运行的 
> ~/.bashrc 是交互式 non-login 方式进入 bash 运行的 

## 3. mac osx zsh

Mac OSX, 使用 zsh, 发现 /etc/profile 不会被执行。

~/.zshrc 与 /etc/zshenv 这两个文件，都是每次启动新的 terminal 都会被执行

## 4. quote article

> 整理自网络文章汇总。 如 ： http://blog.chinaunix.net/uid-26435987-id-3400127.html

## 5. my zshrc

```bash
# Path to your oh-my-zsh installation.
export ZSH=/Users/hp/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git)

# User configuration

# export PATH="/usr/share/java/apache-maven/bin:/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/hp/bin"
# export PATH="/usr/share/java/apache-maven/bin:/usr/local/opt/coreutils/libexec/gnubin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/Users/hp/bin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#### bash_profile at robby_chan ####
###################################################
if brew list | grep coreutils > /dev/null ; then
  PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
  alias ls='ls -F --show-control-chars --color=auto'
  eval `gdircolors -b $HOME/.dir_colors`
fi
alias grep='grep --color'
alias egrep='egrep --color'
alias fgrep='fgrep --color'

###################################################
alias x='sh $xe'
alias x0='sh $xe0'
alias x8='sh $xe8'
#alias ct='sh $centos01_libin'
#alias cth='sh $centos01_hp'
#alias ll='ls -l'
xe=/usr/local/xSoft/comany_soft_tool/libin196.sh
xe0=/usr/local/xSoft/comany_soft_tool/libin190.sh
xe8=/usr/local/xSoft/comany_soft_tool/libin198.sh
centos01_libin=/usr/local/xSoft/comany_soft_tool/centos01_libin.sh
centos01_hp=/usr/local/xSoft/comany_soft_tool/centos01_hp.sh
#.bash_profile


#Get the aliases and functions
if [ -f ~/.bashrc ]; then
    source ~/.bashrc
fi

#PS1="[\u@\h \W]\$ "
#export JAVA_HOME=`/usr/libexec/java_home`
#JAVA_HOME=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home
#JAVA_HOME=/System/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home

MS=/usr/local/xSoft

### JAVA ###
JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home
JAVA_BIN=$JAVA_HOME/bin
PATH=$JAVA_HOME/bin:$PATH    
CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/jre/lib/dt.jar:$JAVA_HOME/jre/lib/tools.jar
export JAVA_HOME JAVA_BIN PATH CLASSPATH

### Maven ###
M2_HOME=/usr/local/xSoft/apache-maven
MAVEN_HOME=$M2_HOME
M3_HOME=$M2_HOME
PATH=$M3_HOME/bin:$PATH    
export MAVEN_HOME M2_HOME PATH
#MAVEN_OPTS=-Xms128m -Xmx512m

### Scala ###
#export SCALA_HOME=/usr/local/xSoft/scala
export SCALA_HOME=/usr/local/Cellar/scala/2.11.5
export PATH=${SCALA_HOME}/bin:$PATH

### Spark ###
export SPARK_HOME=/usr/local/xSoft/spark

### Tomcat ###
CATALINA_HOME=/usr/local/xSoft/apache-tomcat
PATH=$CATALINA_HOME/bin:$PATH
export CATALINA_HOME PATH

## Jetty ##
JETTY_HOME=/usr/local/xSoft/jetty8

### ElasticSearch ###
export ES_HOME=/usr/local/xSoft/elasticsearch

### HADOOP ###
export HADOOP_INSTALL=/usr/local/hadoop
export PATH=$PATH:$HADOOP_INSTALL/bin
export PATH=$PATH:$HADOOP_INSTALL/sbin
export HADOOP_MAPRED_HOME=$HADOOP_INSTALL
export HADOOP_COMMON_HOME=$HADOOP_INSTALL
export HADOOP_HDFS_HOME=$HADOOP_INSTALL
export YARN_HOME=$HADOOP_INSTALL

### Python
#export PATH=/System/Library/Frameworks/Python.framework/Versions/3.5/bin:${PATH}
export PATH=/System/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}


#################################################
# User specific environment and startup programs
PATH=$PATH:$HOME/bin
export PATH="/usr/local/bin:/usr/local/sbib:$PATH"
export PATH

export LC_ALL=en_US.UTF-8

export NVM_DIR="/Users/hp/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
```