---
title: New Mac Install Brew Iterm Zsh
date: 2017-03-22 16:43:21
categories: devops
tags: [mac]
---

新机 mac 安装一些常用软件

<!-- more -->

## 1. install homebrew

Mac 下面的包管理工具，通过 Github 托管适合 Mac 的编译配置以及 Patch，可以方便的安装开发工具。

Mac 自带ruby 所以安装起来很方便，同时它也会自动把git也给你装上。

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

> 安装过程可能会有点慢，完成之后，建议执行一下自检，brew doctor
> 看到
> Your system is ready to brew. 
> 那么恭喜你的 brew 已经可以开始使用了。

```
brew install wget tree
```
---

brew 常用命令： （所有软件以PHP5.5为例子）

```bash
brew update                        #更新brew可安装包，建议每次执行一下
brew search php55                  #搜索php5.5
brew tap josegonzalez/php          #安装扩展<gihhub_user/repo> 
brew tap                          #查看安装的扩展列表
brew install php55                #安装php5.5
brew remove  php55                #卸载php5.5
brew upgrade php55                #升级php5.5
brew options php55                #查看php5.5安装选项
brew info    php55                #查看php5.5相关信息
brew home    php55                #访问php5.5官方网站
brew services list                #查看系统通过 brew 安装的服务
brew services cleanup              #清除已卸载无用的启动配置文件
brew services restart php55        #重启php-fpm
 
注意：brew services 相关命令最好别经常用了，提示会被移除
```

## 2. install zsh

ohmyzsh & iTerm2 两个神器，在Mac os x下是一定要装的. 
 
### 2.1 install onmyzsh

``` 
curl -L http://install.ohmyz.sh | sh
```

### 2.2 install zsh

在 Terminal 下，直接敲 zsh.

> 下面请暂时忽略 

---

设置默认shell

```
cat /etc/shells 
# List of acceptable shells for chpass(1). 
# Ftpd will not allow users to connect who are not using 
# one of these shells. /bin/bash /bin/csh /bin/ksh /bin/sh /bin/tcsh /bin/zsh zsh --version zsh 5.0.2 (x86_64-apple-darwin13.0) chsh -s /bin/zsh
```

虽然Mac自带了zsh，如果你想要最新版的zsh，那么你用 brew install zsh安装一个最新的吧。

```
/usr/local/bin/zsh --version
```
zsh 5.0.5 (x86_64-apple-darwin13.3.0) 区别也不会很大， 默认的版本已经很新了。  

安装后最好备份 : cp ~/.zshrc ~/.zshrc.orig
 

## 3. homebrew-cask

install brew cask

```bash
brew tap phinze/homebrew-cask
```

cask常用命令：
 
```
brew cask search        #列出所有可以被安装的软件
brew cask search php    #查找所有和php相关的应用
brew cask list          #列出所有通过cask安装的软件
brew cask info phpstorm #查看 phpstorm 的信息
brew cask uninstall qq  #卸载 QQ
```

> brew cask install sublime-text
 
这里谈谈cask对比Mac App Store的优势：
 
- 对常用软件支持更全面（特别是开发者），cask里面会给你一些惊喜；
- 软件更新速度快，一般都是最新版本 Store上很久很久才会更新版本；
- 命令安装感觉比打开Store方便，另外Store在国内的速度也是XXOO。

> homebrew-cask 你可以先不安装

## 4. iterm2

 https://www.iterm2.com/

## 5. SimpleHTTPServer

A computer

```
python -m http.server
```

B computer

```
wget http://192.168.xx.xx:8000/your-filename
```

> nc 瑞士军刀，也可以两台电脑传输文件
