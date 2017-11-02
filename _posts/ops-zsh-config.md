---
title: My Zsh Config Files
toc: true
date: 2017-10-21 18:16:21
categories: devops
tags: zshrc
---

 `~/.zprofile` and `~/.zshrc` custom config

<!-- more -->

## .zprofile

```zsh
###################################################
###       blair custom config @2017.10.21       ###
###################################################

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

### Pyenv ###
export PATH="/Users/blair/.pyenv/bin:$PATH"
alias pyenv_init='eval "$(pyenv init -)" && eval "$(pyenv virtualenv-init -)"'
pyenv_init
#export PYENV_VIRTUALENV_DISABLE_PROMPT=1

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

# pip list
alias pipl='pip list --format=columns'

# lsof -i:port
alias lsofi='lsof -i:'

# http_proxy
alias hp="http_proxy=http://localhost:8123"
alias hps="https_proxy=http://localhost:8123"

# hexo
alias hx='source ~/.nvm/nvm.sh'
alias hs='hx && cd ~/ghome/blog && hexo s'

# deploy blog
alias db='hx && cd ~/ghome/blog && hexo clean && sh dp.sh'
alias dg='cd ~/ghome/blog && hexo clean && sh dp.sh'

# pyenv
alias pyenv_install_python_pre='source $MS/custom-machine/pyenv-install.sh'
alias py2='pyenv_init && pyenv activate vpy2 && clear && python -V'
alias py3='pyenv_init && pyenv activate vpy3 && clear && python -V'
alias pyde='pyenv deactivate'
alias pys='pyenv activate vpy3 && pyenv global system && pyde && python -V'

# zshrc
alias vzp='vim ~/.zprofile'
alias szp='source ~/.zprofile'
```

## .zshrc

```zsh
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/blair/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
# by blair add @2017-10-10
#ZSH_THEME="ys" 
ZSH_THEME="astro" 

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

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
plugins=(git autojump) # by blair add @2017-10-10
#[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

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
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

###################################################
###       blair custom config @2017.10.21       ###
###################################################

### Fast Login Machine Function ###
# ssh add
alias sd='ssh-add'
alias x2='ssh loguser@192.168.***.*'
```
