---
title: Pyenv Install For Virtual Multi Python Version Switch
toc: true
date: 2017-10-18 20:16:21
categories: devops
tags: help
---

It needs to be used in both python2 and python3 environments, or different packages need to be installed in different projects.

<!-- more -->

we hope that the packages installed between different projects do not interfere with each other, and then you can configure the virtual environment of Python using pyenv.

## installation pyenv

[Official Pyenv Install][p4]

```bash
export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
#export PYENV_VIRTUALENV_DISABLE_PROMPT=1
```

> 按照官方文档配置即可，mac zsh 用户，将 以上三句放入到 .zshrc 即可。

## see available versions

```
pyenv install -l
```

## install python in virtual env

install python 2.7.14

```
pyenv install 2.7.14
```

install python 3.6.3

```
pyenv install 3.6.3
```

>  [solve macOS High Sierra: ERROR: The Python ssl extension was not compiled. Missing the OpenSSL lib?][1]
> 
> ```
# about zlib
export CFLAGS="-I$(xcrun --show-sdk-path)/usr/include"
# about readline
export CFLAGS="-I$(brew --prefix readline)/include $CFLAGS"
export LDFLAGS="-L$(brew --prefix readline)/lib $LDFLAGS"
# about openssl
export CFLAGS="-I$(brew --prefix openssl)/include $CFLAGS"
export LDFLAGS="-L$(brew --prefix openssl)/lib $LDFLAGS"
# about SQLite (maybe not necessary)
export CFLAGS="-I$(brew --prefix sqlite)/include $CFLAGS"
export LDFLAGS="-L$(brew --prefix sqlite)/lib $LDFLAGS"
```

Set or show the global Python version

```
$ pyenv global 3.6.3 or system
```

> system stands for this mac

show list all Python versions available to pyenv

```
$ pyenv versions
```

## create virtual env

create current `3.6.3 version python` virtual env

```
$ pyenv virtualenv vpy3
```

> **vpy3** is this virtual env alias

## pyenv activate & deactivate

```
$ pyenv activate vpy3
```

> 这是时候就可以开始pip安装依赖包了

```
➜ pyenv activate vpy3
pyenv-virtualenv: prompt changing will be removed from future release. configure `export PYENV_VIRTUALENV_DISABLE_PROMPT=1' to simulate the behavior.
(vpy3)
# ~ [12:25:44]
➜ python -V
Python 3.6.3
(vpy3)
# ~ [12:25:49]
➜ pyenv deactivate vpy3
# ~ [12:25:57]
➜ python -V
Python 2.7.10
```

[1]: https://github.com/pyenv/pyenv/issues/993

[p4]: https://github.com/pyenv/pyenv-installer







