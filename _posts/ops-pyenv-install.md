---
title: Pyenv Install For Virtual Multi Python Version Switch
toc: true
date: 2017-10-18 20:16:21
categories: devops
tags: help
---

It needs to be developed in both python2 and python3 environments, or different packages need to be installed in different projects, we hope that the packages installed between different projects do not interfere with each other, and then you can configure the virtual environment of Python using pyenv.

<!-- more -->

## Installation Pyenv

[Official Pyenv Install][p4]

```bash
export PATH="~/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
```

> 按照官方文档配置即可，mac zsh 用户，将 以上三句放入到 .zshrc 即可。

you should see available versions

```
pyenv install -l
```


[p4]: https://github.com/pyenv/pyenv-installer







