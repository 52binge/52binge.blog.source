---
title: Mac OSX pip OSError [Errno 1] Operation not permitted
toc: true
date: 2017-10-17 17:21:21
categories: ops
tags: gensim
mathjax: true
---

Solved Mac OSX pip OSError, When you pip install python lib about machine-learning package.

<!-- more -->

```bash
pip install --upgrade gensim
```

结果抛出下面这个异常报告

```
OSError: [Errno 1] Operation not permitted: '/tmp/pip-pvGyz6-uninstall/System/Library/Frameworks/Python.framework/Versions/2.7/Extras/lib/python/numpy, scipy, ...
```

google 后解决方案 :

```bash
$ pip install --upgrade pip

$ sudo pip install numpy --upgrade --ignore-installed
$ sudo pip install scipy --upgrade --ignore-installed
$ sudo pip install scikit-learn --upgrade --ignore-installed
```
