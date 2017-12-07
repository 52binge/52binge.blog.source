---
title: Pyenv Install Anaconda3
toc: true
date: 2017-12-07 10:16:21
categories: devops
tags: Anaconda3
---

Pyenv + IPython + Jupyter Notebook + Anaconda3

pyenv install anaconda3-5.0.0 无法下载包的情况下使用的，因为网速实在太慢了T T

<!-- more -->

## Anaconda3

[官网][1] 下载了.sh文件，在该.sh文件目录使用下面的命令安装该文件

Anaconda3-5.0.1-MacOSX-x86_64.sh
	
```
➜  mv Anaconda3-5.0.1-MacOSX-x86_64.sh ~/.pyenv/cache/
➜  cache git:(master) sh Anaconda3-5.0.1-MacOSX-x86_64.sh
```

安装过程需要操作的地方：

```
Please, press ENTER to continue
>>>
...
Do you accept the license terms? [yes|no]
[no] >>> yes
```

```
Anaconda3 will now be installed into this location:
/Users/blair/anaconda3	
- Press ENTER to confirm the location
- Press CTRL-C to abort the installation
- Or specify a different location below
```

> [/Users/blair/anaconda3] 改为 /Users/blair/.pyenv/versions/anaconda3
>
> 输入需要安装的目录，因为要添加到pyenv管理器中，所以与其他以安装的Python版本放在同一目录下。

开始输出安装信息，会安装许多包：

```
[/Users/blair/anaconda3] >>> /Users/blair/.pyenv/versions/anaconda3
PREFIX=/Users/blair/.pyenv/versions/anaconda3
installing: python-3.6.3-h6804ab2_0 ...
Python 3.6.3 :: Anaconda, Inc.
installing: bzip2-1.0.6-h92991f9_1 ...
installing: ca-certificates-2017.08.26-ha1e5d58_0 ...
installing: conda-env-2.6.0-h36134e3_0 ...
……
```

然后出现提示，输入yes即可

```
installation finished.
Do you wish the installer to prepend the Anaconda3 install location
to PATH in your /Users/blair/.bash_profile ? [yes|no]
[yes] >>> yes
```

安装成功！

```bash
➜ pyenv versions
  system
  2.7.14
  2.7.14/envs/vpy2
  3.5.4
  3.5.4/envs/vpy3.5
* anaconda3 (set by /Users/blair/.pyenv/version)
  anaconda3/envs/vconda3
  vconda3
  vpy2
  vpy3.5
(anaconda3)
# ~/ghome [10:34:54]
```

为anaconda3创建虚拟环境

```
➜  cache git:(master) pyenv virtualenv vconda3
```

可能会装一些更新包，会有提示：

```
 #
 # To activate this environment, use:
 # > source activate vconda3
 #
 # To deactivate an active environment, use:
 # > source deactivate
```

根据提示激活：

```
➜  cache git:(master) source activate vconda3
```

[1]: https://repo.continuum.io/archive/Anaconda3-5.0.1-MacOSX-x86_64.sh
