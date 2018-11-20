---
title: Mac install tensorFlow
date: 2017-02-21 09:54:16
tags: [tensorflow]
categories: devops
toc: true
list_number: false
description: install tensorflow
---

## 1. instaled pip

```bash
# 安装完后执行命令pip freeze列出安装的packages验证一下pip安装好没.

$ pip freeze
python-dateutil==1.5
scikit-learn==0.18.dev0
scipy==0.13.0b1
six==1.10.0
tensorflow==0.5.0
terminado==0.6
TFL==2.0.5
tornado==4.3
vboxapi==1.0
virtualenv==15.1.0
...
```

## 2. install tensorflow

```bash
# Mac OS X, CPU only, Python 2.7:
$ export TF_BINARY_URL=https://storage.googleapis.com/tensorflow/mac/cpu/tensorflow-1.0.0-py2-none-any.whl

# Only CPU-version is available at the moment.
$ sudo pip install $TF_BINARY_URL
```

> maybe by vpn in China

## 3. install virtualenv

virtualenv是python的沙箱工具.我们毕竟是在自己机器上做实验,为了不来回修改各种环境变量,我们一般还是弄个沙箱完比较好.测试完直接删除就行,不用再去改各种配置文件.


```bash
$ sudo pip install --upgrade virtualenv

Collecting virtualenv
  Downloading virtualenv-15.1.0-py2.py3-none-any.whl (1.8MB)
    100% |████████████████████████████████| 1.8MB 156kB/s
Installing collected packages: virtualenv
Successfully installed virtualenv-15.1.0
```

安装好后创建一个工作目录,我直接在home里创建了个文件夹.

```bash
$ virtualenv --system-site-packages ~/tensorflow
```

然后进入目录激活沙箱.

```
$ cd ~/tensorflow
$ source bin/activate
```

## 4. install tensorflow in virtualenv

```bash
(tensorflow) ➜  tensorflow pip install $TF_BINARY_URL
```

## 5. run tensorflow

[hello world][1]

```python
(tensorflow) ➜  tensorflow python
Python 2.7.10 (default, Jul 14 2015, 19:46:27)
[GCC 4.2.1 Compatible Apple LLVM 6.0 (clang-600.0.39)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> import tensorflow as tf
>>> hello = tf.constant('Hello,TensorFlow!')
>>> sess = tf.Session()
can't determine number of CPU cores: assuming 4
I tensorflow/core/common_runtime/local_device.cc:25] Local device intra op parallelism threads: 4
can't determine number of CPU cores: assuming 4
I tensorflow/core/common_runtime/local_session.cc:45] Local session inter op parallelism threads: 4
>>> print sess.run(hello)
Hello,TensorFlow!
>>>
```

let's see this tensorflow dir

```bash
➜  tensorflow ll
total 4.0K
drwxr-xr-x 16 hp staff 544 Feb 21 10:45 bin/
drwxr-xr-x  3 hp staff 102 Feb 21 10:38 include/
drwxr-xr-x  3 hp staff 102 Feb 21 10:38 lib/
-rw-r--r--  1 hp staff  60 Feb 21 10:45 pip-selfcheck.json
➜  tensorflow
```

## 6. install keras

```bash
sudo pip install keras

Successfully installed keras-1.2.2 pyyaml-3.12 theano-0.8.2
```

## Refence

 1. [tensorflow官方地址][2]
 2. [pip官方地址][3]
 3. [setuptools官方地址][4]
 4. [python安装setuptools步骤详解][5]
 5. [about pdf文件下载][6]
 6. [tflearn.org/installation][7]

[1]: http://tensorflow.org/get_started/os_setup.md#try_your_first_tensorflow_program
[2]: http://tensorflow.org
[3]: https://pypi.python.org/pypi/pip
[4]: https://pypi.python.org/pypi/setuptools
[5]: http://www.111cn.net/phper/python/66848.htm
[6]: http://pan.baidu.com/s/1c1corG8
[7]: http://tflearn.org/installation/#upgrade-tensorflow
