---
title: MacOS Mojave 10.14.6 Work Environment Install
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

## 2. Dev Tools

### 2.1 general dev tool

 1. Macdown
 2. Alfred
 3. SubLime Text
 4. [Homebrew](https://brew.sh/)
 5. Iterm2
 6. [Oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
 7. [PyCharm & IDEA][3]

> brew (install 过程会自动需要 Xcode 被安装)
> brew install wget tree 
> 
> 待定 wget https://bootstrap.pypa.io/get-pip.py <br>
> 待定 sudo python get-pip.py

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
>
> Iterm2 -> Preference -> Profiles -> 右下角 -> import JSON profiles -> HotKey Window.json (MyProfiles)

<details><summary>HotKey Window.json</summary>

```json
{
  "Working Directory" : "\/Users\/blair",
  "Prompt Before Closing 2" : false,
  "Selected Text Color" : {
    "Green Component" : 0,
    "Red Component" : 0,
    "Blue Component" : 0
  },
  "Rows" : 25,
  "Ansi 11 Color" : {
    "Green Component" : 1,
    "Red Component" : 1,
    "Blue Component" : 0.3333333432674408
  },
  "Use Italic Font" : true,
  "HotKey Characters" : "",
  "Foreground Color" : {
    "Green Component" : 0.73333334922790527,
    "Red Component" : 0.73333334922790527,
    "Blue Component" : 0.73333334922790527
  },
  "HotKey Window Floats" : true,
  "Right Option Key Sends" : 0,
  "Character Encoding" : 4,
  "Selection Color" : {
    "Green Component" : 0.8353000283241272,
    "Red Component" : 0.70980000495910645,
    "Blue Component" : 1
  },
  "Mouse Reporting" : true,
  "Ansi 4 Color" : {
    "Green Component" : 0,
    "Red Component" : 0,
    "Blue Component" : 0.73333334922790527
  },
  "Non-ASCII Anti Aliased" : true,
  "Sync Title" : false,
  "Disable Window Resizing" : true,
  "Description" : "Default",
  "Close Sessions On End" : true,
  "Jobs to Ignore" : [
    "rlogin",
    "ssh",
    "slogin",
    "telnet"
  ],
  "Scrollback Lines" : 1000,
  "HotKey Window Reopens On Activation" : false,
  "Prevent Opening in a Tab" : false,
  "Flashing Bell" : false,
  "Cursor Guide Color" : {
    "Red Component" : 0.70213186740875244,
    "Color Space" : "sRGB",
    "Blue Component" : 1,
    "Alpha Component" : 0.25,
    "Green Component" : 0.9268307089805603
  },
  "BM Growl" : true,
  "Ansi 3 Color" : {
    "Green Component" : 0.73333334922790527,
    "Red Component" : 0.73333334922790527,
    "Blue Component" : 0
  },
  "Use Non-ASCII Font" : false,
  "Link Color" : {
    "Red Component" : 0,
    "Color Space" : "sRGB",
    "Blue Component" : 0.73423302173614502,
    "Alpha Component" : 1,
    "Green Component" : 0.35916060209274292
  },
  "Shortcut" : "",
  "Background Image Location" : "",
  "Bold Color" : {
    "Green Component" : 1,
    "Red Component" : 1,
    "Blue Component" : 1
  },
  "Unlimited Scrollback" : false,
  "Custom Command" : "No",
  "HotKey Key Code" : 49,
  "Keyboard Map" : {
    "0xf700-0x260000" : {
      "Text" : "[1;6A",
      "Action" : 10
    },
    "0x37-0x40000" : {
      "Text" : "0x1f",
      "Action" : 11
    },
    "0x32-0x40000" : {
      "Text" : "0x00",
      "Action" : 11
    },
    "0xf709-0x20000" : {
      "Text" : "[17;2~",
      "Action" : 10
    },
    "0xf70c-0x20000" : {
      "Text" : "[20;2~",
      "Action" : 10
    },
    "0xf729-0x20000" : {
      "Text" : "[1;2H",
      "Action" : 10
    },
    "0xf72b-0x40000" : {
      "Text" : "[1;5F",
      "Action" : 10
    },
    "0xf705-0x20000" : {
      "Text" : "[1;2Q",
      "Action" : 10
    },
    "0xf703-0x260000" : {
      "Text" : "[1;6C",
      "Action" : 10
    },
    "0xf700-0x220000" : {
      "Text" : "[1;2A",
      "Action" : 10
    },
    "0xf701-0x280000" : {
      "Text" : "0x1b 0x1b 0x5b 0x42",
      "Action" : 11
    },
    "0x38-0x40000" : {
      "Text" : "0x7f",
      "Action" : 11
    },
    "0x33-0x40000" : {
      "Text" : "0x1b",
      "Action" : 11
    },
    "0xf703-0x220000" : {
      "Text" : "[1;2C",
      "Action" : 10
    },
    "0xf701-0x240000" : {
      "Text" : "[1;5B",
      "Action" : 10
    },
    "0xf70d-0x20000" : {
      "Text" : "[21;2~",
      "Action" : 10
    },
    "0xf702-0x260000" : {
      "Text" : "[1;6D",
      "Action" : 10
    },
    "0xf729-0x40000" : {
      "Text" : "[1;5H",
      "Action" : 10
    },
    "0xf706-0x20000" : {
      "Text" : "[1;2R",
      "Action" : 10
    },
    "0x34-0x40000" : {
      "Text" : "0x1c",
      "Action" : 11
    },
    "0xf700-0x280000" : {
      "Text" : "0x1b 0x1b 0x5b 0x41",
      "Action" : 11
    },
    "0x2d-0x40000" : {
      "Text" : "0x1f",
      "Action" : 11
    },
    "0xf70e-0x20000" : {
      "Text" : "[23;2~",
      "Action" : 10
    },
    "0xf702-0x220000" : {
      "Text" : "[1;2D",
      "Action" : 10
    },
    "0xf703-0x280000" : {
      "Text" : "0x1b 0x1b 0x5b 0x43",
      "Action" : 11
    },
    "0xf700-0x240000" : {
      "Text" : "[1;5A",
      "Action" : 10
    },
    "0xf707-0x20000" : {
      "Text" : "[1;2S",
      "Action" : 10
    },
    "0xf70a-0x20000" : {
      "Text" : "[18;2~",
      "Action" : 10
    },
    "0x35-0x40000" : {
      "Text" : "0x1d",
      "Action" : 11
    },
    "0xf70f-0x20000" : {
      "Text" : "[24;2~",
      "Action" : 10
    },
    "0xf703-0x240000" : {
      "Text" : "[1;5C",
      "Action" : 10
    },
    "0xf701-0x260000" : {
      "Text" : "[1;6B",
      "Action" : 10
    },
    "0xf702-0x280000" : {
      "Text" : "0x1b 0x1b 0x5b 0x44",
      "Action" : 11
    },
    "0xf72b-0x20000" : {
      "Text" : "[1;2F",
      "Action" : 10
    },
    "0x36-0x40000" : {
      "Text" : "0x1e",
      "Action" : 11
    },
    "0xf708-0x20000" : {
      "Text" : "[15;2~",
      "Action" : 10
    },
    "0xf701-0x220000" : {
      "Text" : "[1;2B",
      "Action" : 10
    },
    "0xf70b-0x20000" : {
      "Text" : "[19;2~",
      "Action" : 10
    },
    "0xf702-0x240000" : {
      "Text" : "[1;5D",
      "Action" : 10
    },
    "0xf704-0x20000" : {
      "Text" : "[1;2P",
      "Action" : 10
    }
  },
  "Ansi 14 Color" : {
    "Green Component" : 1,
    "Red Component" : 0.3333333432674408,
    "Blue Component" : 1
  },
  "Ansi 2 Color" : {
    "Green Component" : 0.73333334922790527,
    "Red Component" : 0,
    "Blue Component" : 0
  },
  "Send Code When Idle" : false,
  "ASCII Anti Aliased" : true,
  "Tags" : [

  ],
  "Ansi 9 Color" : {
    "Green Component" : 0.3333333432674408,
    "Red Component" : 1,
    "Blue Component" : 0.3333333432674408
  },
  "Use Bold Font" : true,
  "Silence Bell" : false,
  "Ansi 12 Color" : {
    "Green Component" : 0.3333333432674408,
    "Red Component" : 0.3333333432674408,
    "Blue Component" : 1
  },
  "Window Type" : 0,
  "Use Bright Bold" : true,
  "Has Hotkey" : true,
  "HotKey Modifier Activation" : 0,
  "Cursor Text Color" : {
    "Green Component" : 1,
    "Red Component" : 1,
    "Blue Component" : 1
  },
  "HotKey Window Dock Click Action" : 0,
  "Default Bookmark" : "No",
  "Cursor Color" : {
    "Green Component" : 0.73333334922790527,
    "Red Component" : 0.73333334922790527,
    "Blue Component" : 0.73333334922790527
  },
  "Ansi 1 Color" : {
    "Green Component" : 0,
    "Red Component" : 0.73333334922790527,
    "Blue Component" : 0
  },
  "Name" : "HotKey Window",
  "Blinking Cursor" : false,
  "Guid" : "93391868-B18E-488D-8281-468CE7F2D96D",
  "Idle Code" : 0,
  "Ansi 10 Color" : {
    "Green Component" : 1,
    "Red Component" : 0.3333333432674408,
    "Blue Component" : 0.3333333432674408
  },
  "Ansi 8 Color" : {
    "Green Component" : 0.3333333432674408,
    "Red Component" : 0.3333333432674408,
    "Blue Component" : 0.3333333432674408
  },
  "Badge Color" : {
    "Red Component" : 1,
    "Color Space" : "sRGB",
    "Blue Component" : 0,
    "Alpha Component" : 0.5,
    "Green Component" : 0.1491314172744751
  },
  "Ambiguous Double Width" : false,
  "Blur Radius" : 3.4086770304568521,
  "Ansi 0 Color" : {
    "Green Component" : 0,
    "Red Component" : 0,
    "Blue Component" : 0
  },
  "Blur" : true,
  "Normal Font" : "CourierNewPS-BoldMT 17",
  "Vertical Spacing" : 1,
  "Ansi 7 Color" : {
    "Green Component" : 0.73333334922790527,
    "Red Component" : 0.73333334922790527,
    "Blue Component" : 0.73333334922790527
  },
  "HotKey Window AutoHides" : true,
  "Command" : "",
  "Terminal Type" : "xterm-256color",
  "Horizontal Spacing" : 1,
  "Option Key Sends" : 0,
  "HotKey Window Animates" : true,
  "HotKey Modifier Flags" : 1179648,
  "Ansi 15 Color" : {
    "Green Component" : 1,
    "Red Component" : 1,
    "Blue Component" : 1
  },
  "Ansi 6 Color" : {
    "Green Component" : 0.73333334922790527,
    "Red Component" : 0,
    "Blue Component" : 0.73333334922790527
  },
  "Transparency" : 0.13976840101522844,
  "HotKey Activated By Modifier" : false,
  "Background Color" : {
    "Green Component" : 0,
    "Red Component" : 0,
    "Blue Component" : 0
  },
  "Screen" : -2,
  "HotKey Characters Ignoring Modifiers" : " ",
  "Bound Hosts" : [

  ],
  "Non Ascii Font" : "Monaco 12",
  "Ansi 13 Color" : {
    "Green Component" : 0.3333333432674408,
    "Red Component" : 1,
    "Blue Component" : 1
  },
  "Columns" : 77,
  "HotKey Alternate Shortcuts" : [

  ],
  "Use Tab Color" : true,
  "Visual Bell" : true,
  "Custom Directory" : "No",
  "Ansi 5 Color" : {
    "Green Component" : 0,
    "Red Component" : 0.73333334922790527,
    "Blue Component" : 0.73333334922790527
  },
  "Set Local Environment Vars" : false
}
```

</details>

**oh-my-zsh 自带 git 插件，里面的针对git 的别名设置见**:

> ➜ >vim .oh-my-zsh/plugins/git/git.plugin.zsh

**my_zprofile**

[.zprofile](/2017/10/21/devops/oh-my-zsh-config/)

**my_vimrc**

[.vimrc](/2017/10/04/devops/my-vimrc/)

**oh-my-zsh autojump plugin install**

1. brew install autojump
2. vim .zshrc

```bash
plugins=(git autojump)
[[ -s $(brew --prefix)/etc/profile.d/autojump.sh ]] && . $(brew --prefix)/etc/profile.d/autojump.sh
```

then, source ~/.zshrc


if Folder permission "Insecure completion-dependent directories detected", then:

vim .zshrc

```bash
Set ZSH_DISABLE_COMPFIX=true 
#  in your zshrc file, before oh-my-zsh.sh is sourced, and update OMZ to the latest version. It should ignore these permission issues and load the completion system normally.
```

then, source ~/.zshrc

**Astro zsh theme add in .zshrc** [Astro zsh theme, download and move to target dir, then:](https://github.com/iplaces/astro-zsh-theme)

```bash
ZSH_THEME="astro"
```

then, source ~/.zshrc

**也加载下 .bash_profile**

~/.zshrc, tail line add

```bash
source ~/.bash_profile
```

then, source ~/.zshrc

[iTerm2 如何设置半透明窗口？](https://zhuanlan.zhihu.com/p/234766527)

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

### 2.3 Miniconda

[https://docs.conda.io/en/latest/miniconda.html](https://docs.conda.io/en/latest/miniconda.html)

> Miniconda3 MacOSX 64-bit pkg
	
~/.zshrc, tail line add

```bash
source ~/.bash_profile
```

then, source ~/.zshrc

```bash
➜ conda info

     active environment : base
    active env location : /opt/miniconda3
            shell level : 1
       user config file : /Users/blair/.condarc
 populated config files :
          conda version : 4.9.2
    conda-build version : not installed
         python version : 3.9.1.final.0
       virtual packages : __osx=10.14.6=0
                          __unix=0=0
                          __archspec=1=x86_64
       base environment : /opt/miniconda3  (writable)
           channel URLs : https://repo.anaconda.com/pkgs/main/osx-64
                          https://repo.anaconda.com/pkgs/main/noarch
                          https://repo.anaconda.com/pkgs/r/osx-64
                          https://repo.anaconda.com/pkgs/r/noarch
          package cache : /opt/miniconda3/pkgs
                          /Users/blair/.conda/pkgs
       envs directories : /opt/miniconda3/envs
                          /Users/blair/.conda/envs
               platform : osx-64
             user-agent : conda/4.9.2 requests/2.25.0 CPython/3.9.1 Darwin/18.7.0 OSX/10.14.6
                UID:GID : 501:20
             netrc file : None
           offline mode : False
```

```bash
➜ python -V
Python 3.9.1
(base)
# ~ [18:54:12]
➜ pip --version
pip 20.3.1 from /opt/miniconda3/lib/python3.9/site-packages/pip (python 3.9)
(base)
# ~ [18:54:14]
➜
```

create env foo & install common package

```bash
conda create --name foo
conda info
conda info --envs
conda activate foo
conda list
conda install pip
pip list
pip install pandas numpy scikit-learn matplotlib ipython notebook
# 优先用 pip 来安装 package, pip 不行, 在用 conda. 浩哥的习惯. 推荐不绝对
```

[只用来管理 Python 版本和虚拟环境，Miniconda 也是一个很好的选择](https://zhuanlan.zhihu.com/p/81321705)

```bash
➜ conda info --envs
# conda environments:
#
base                  *  /opt/miniconda3
foo                      /opt/miniconda3/envs/foo
```

### 2.4 ssh config

1. ssh-keygen -t rsa -C "your-company-email-full-address"
2. ~/.ssh/id_rsa.pub 粘贴到运维平台

> mac iterm2 ssh 跳转失败, 解决办法 :
> 
> (1) 新建并编辑 .ssh/config, 并复制以下内容到 config文件中

```
Host * 
ForwardAgent yes 
PasswordAuthentication yes 
StrictHostKeyChecking no 
HashKnownHosts yes 
Compression yes 
```

> (2) cd ～/.ssh, 并在 terminal 中执行 ssh-add

### 2.5 navicat for MySQL

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

```bash
➜  software pwd
/usr/local/xsoft/software
➜  software ll
total 0
lrwxr-xr-x  1 blair  staff    40B Jun 30  2020 jdk -> /usr/local/xsoft/software/jdk-14.0.1.jdk
lrwxr-xr-x  1 blair  staff    44B Mar 21 08:42 maven -> /usr/local/xsoft/software/apache-maven-3.6.3
drwxr-xr-x@ 7 blair  staff   224B Mar 21 08:42 software
lrwxr-xr-x  1 blair  staff    51B Jul  1  2020 spark -> /usr/local/xsoft/software/spark-3.0.0-bin-hadoop3.2
➜  software
```

## 4. Blog

[nvm node.js](https://www.cnblogs.com/gaozejie/p/10689742.html)

 1. [hexo][5]
 2. Install Node.js

```
$ wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.35.2/install.sh | bash
```
> Once nvm is installed, restart the terminal and run the following command to install Node.js:

```
# $ nvm install v4.1.0
$ nvm install v14.17.1
$ npm install -g hexo-cli
```

## 5. Python (待定)

### 5.1 this mac install pip (待定)

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

### 5.2 pyenv install package (待定)

**First, you need to install python `pyenv` environment**

```py
Python 3.6.3
(vpy3)
➜

pip install numpy
pip install scipy
pip install matplotlib
pip install pandas

pip install scikit-learn
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