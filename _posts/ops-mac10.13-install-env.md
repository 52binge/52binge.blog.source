---
title: Macos High Sierra 10.13 Work Environment Install
toc: true
date: 2017-10-03 07:08:21
categories: devops
tags: macos
description: new macos high sierra install env
---

Enable Dragging With Three Finger : 
 
> System Preferences -> Accessibility -> Mouse & Trackpad -> Trackpad Options.

<!-- more -->

## 1. Common Soft

 1. Chrome
 2. NeteaseMusic
 3. Baiduyun & Aira2GUI
 4. Microsoft\_Office\_2016\_15.38.17090200\_Installer.pkg

> Google Chrome is up to date
> Version 61.0.3163.100 (Official Build) (64-bit)
>
> 百度云破解限速 (Aria2GUI + chrome plugin)
> 
> Evernote 国际版与国内版分开管理的.

## 2. Dev Tools

### 2.1 general dev tool

 1. Macdown
 2. Alfred
 3. Atom
 4. SubLime Text
 5. [Homebrew][1]
 6. Iterm2
 7. Oh-my-zsh
 8. [PyCharm & IDEA][3]
 9. GNU\_Octave\_3.8.0-6.dmg

> brew (install 过程会自动需要 Xcode 被安装)
> brew install wget tree 
> 
> wget https://bootstrap.pypa.io/get-pip.py <br>
> sudo python get-pip.py

### 2.2 iterm & zsh

**Iterm2 Change Font**

> Iterm2 -> Preference -> Profiles -> Text -> Change Font -> 17pt Courier New Bold

**Iterm2 Hide scrollbars And title bar**

> Preference -> Appearance 
> 
> 取消 show per-pane title bar with split panes.  
> 勾选 Hide scrollbars

**Iterm2 Color Presets**

> Iterm2 -> Preference -> Profiles -> Color -> Color Presets -> your_theme
> 
> maybe Atom, Brogrammer, Darkside 
> 
> [Zsh astro theme][i3]

**oh-my-zsh 自带 git 插件，里面的针对git 的别名设置见**:

> ➜ >vim .oh-my-zsh/plugins/git/git.plugin.zsh

**oh-my-zsh autojump plugin install**

1. brew install autojump
2. vim .zshrc

```
plugins=(git autojump)
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
```

then, source ~/.zshrc

**Reference Article**

> [Iterm2-color-schemes][i2]   
> [Iterm-colors][i1]  
> [Zsh astro theme][i3]    
> [使用 Zsh 的十大优点][i4].    
> [oh-my-zsh配置你的zsh提高shell逼格终极选择][i5].       
> [打造高效个性Terminal（一）之 iTerm][i6].    
> [打造高效个性Terminal（二）之 zsh][i7].   
> [Mac下的效率工具autojump][i8]

[i1]: https://github.com/bahlo/iterm-colors
[i2]: http://iterm2colorschemes.com/
[i3]: https://github.com/iplaces/astro-zsh-theme
[i4]: http://blog.csdn.net/rapheler/article/details/51505003
[i5]: http://yijiebuyi.com/blog/b9b5e1ebb719f22475c38c4819ab8151.html
[i6]: http://huang-jerryc.com/2016/08/11/%E6%89%93%E9%80%A0%E9%AB%98%E6%95%88%E4%B8%AA%E6%80%A7Terminal%EF%BC%88%E4%B8%80%EF%BC%89%E4%B9%8B%20iTerm/
[i7]: https://segmentfault.com/a/1190000006248107
[i8]: http://www.barretlee.com/blog/2015/03/30/autojump-in-mac/

---

### 2.3 ssh config

1. ssh-keygen -t rsa -C "your-company-email-full-address"
2. ~/.ssh/id_rsa.pub 粘贴到运维平台

> mac iterm2 ssh 跳转失败, 解决办法 :
> 
> (1) 新建并编辑 .ssh/config, 并复制以下内容到 config文件中
>
> ```
Host * 
ForwardAgent yes 
PasswordAuthentication yes 
StrictHostKeyChecking no 
HashKnownHosts yes 
Compression yes 
```

> (2) cd ～/.ssh, 并在 terminal 中执行 ssh-add

### 2.4 navicat for MySQL

![rds-general][s2]

> Encoding 设置为 utf-8 则，查询数据库，汉字乱码，改为 Auto 解决。

![ssh-rds][s1]

[s1]: /images/ops/ops-ssh-rds.png
[s2]: /images/ops/ops-ssh-general.png

## 3. Java

 1. [JDK][4]
 2. Maven
 3. Tomcat
 4. Scala
 5. Spark

```
➜  software pwd
/usr/local/xsoft/software
➜  software ll
total 0
lrwxr-xr-x  apache-maven -> /usr/local/xsoft/deploy/apache-maven-3.3.9
lrwxr-xr-x  apache-tomcat -> /usr/local/xsoft/deploy/apache-tomcat-7.0.59
lrwxr-xr-x  scala -> /usr/local/xsoft/deploy/scala-2.11.7
lrwxr-xr-x  spark -> /usr/local/xsoft/deploy/spark-1.6.3-bin-hadoop2.6
➜  software
```

## 4. Blog

 1. [hexo][5]
 2. Install Node.js

```
$ wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash
```
> Once nvm is installed, restart the terminal and run the following command to install Node.js:

```
$ nvm install v4.1.0
$ npm install -g hexo-cli
```

> v4.1.0 更合适 hexo

## 5. Python

### 5.1 this mac install pip

[Python pip][2] , `sudo python get-pip.py`

then, terminal input `pip list`.

> If exist warning:
> 
> DEPRECATION: The default format will switch to columns in the future. You can use --format=(legacy|columns) (or define a format=(legacy|columns) in your pip.conf under the [list] section) to disable this warning.
>
> solve this warning:
>
> ~.vim ~/.pip/pip.conf
> [list]  
> format=columns  

### 5.2 pyenv install package

**First, you need to install python `pyenv` environment**

```py
Python 3.6.3
(vpy3)
➜

pip install numpy
pip install scipy
pip install matplotlib
pip install pandas

pip install xlrd
pip install xlwt
pip install StatsModels
pip install scikit-learn

pip install jieba
pip install --upgrade gensim
```

**ipython**

```
pip install ipython
```

> 然后, 如 terminall input `ipython` 不存在, 则 pip show ipython,  python -m IPython 试试. 

**notebook**

```bash
#pip install --ignore-installed six
#pip install target-gsheet tap-fixerio
pip install notebook
```

> pip install notebook, 如 macos High Sierra 10.13 报错，则  
> pip install --ignore-installed six  
> pip install target-gsheet tap-fixerio  
> then, pip install notebook

## 8. Reference

 * [Homebrew][1]
 * [Get-pip][2]
 * [IntelliJ、Pycharm激活][3]
 * [Mac OSX 安裝JDK][4]
 * [Hexo Doc][5]
 * [Mac 上完整卸载Node.js][7]
 * [Mac OSX 完整卸载Node.js][8]
 * [node版本管理工具nvm-Mac下安装及使用][9]
 * [XClient.info Mac App][10]
 * [Stackoverflow python on MacOS 10.10 - command not found][11]
 * [Blair python install data mining env][12]

Macos NSNavRecentPlaces 内部自动生成的配置，别乱改。

> defaults write -g NSNavRecentPlaces '("~/Desktop", "/usr/local/xsoft/software")';
 
 
[1]: https://brew.sh/
[2]: https://bootstrap.pypa.io/get-pip.py
[3]: https://feiyang.li/2017/02/26/jetbrains/index.html
[4]: http://blog.tibame.com/?p=2068
[5]: https://hexo.io/docs/
[7]: http://www.jianshu.com/p/3e0206dd23ac
[8]: http://10176523.cn/archives/50
[9]: https://segmentfault.com/a/1190000004404505
[10]: http://xclient.info/
[11]: https://stackoverflow.com/questions/32856194/ipython-on-macos-10-10-command-not-found
[12]: /2016/08/02/ml-python-env/