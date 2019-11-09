---
title: Anaconda + Tensorflow 环境搭建
toc: true
date: 2019-11-08 22:00:21
categories: devops
tags: Anaconda
---

<img src="/images/devops/Anaconda-Jupyter-Tensorflow.png" width="550" alt="bert 遇见 keras" />

<!-- more -->

## 1. Anaconda

### 1.1 Anaconda 常用命令

```bash
conda --version
conda update conda
```

```
# 帮助命令
conda -h

# 更新所有包
conda update --all
conda upgrade --all
```

### 1.2 Anaconda 管理环境

```bash
conda create --name <env_name> <package_names>
```

> 如： conda create -n python3 python=3.5 numpy pandas 
> 
>   即创建一个名为“python3”的环境，环境中安装版本为3.5的python，同时也安装了numpy和pandas。

```bash
conda info --envs

conda env list

source activate <env_name>
```


```bash
# 复制环境
conda create --name <new_env_name> --clone <copied_env_name>

# 删除环境
conda remove --name <env_name> --all
```

```bash
pip list / conda list

# 当使用 conda install 无法进行安装时，可以使用pip进行安装
pip install <package_name>
```


## 2. Tensorflow

```bash
conda install pandas xlrd
```

```bash
conda install keras==2.2.4
pip install keras-bert
```

```bash
conda install tensorflow=='1.11.0'
conda install tensorflow-gpu=='1.11.0'
```

## 3. GPU

```bash
nvidia-smi

+-----------------------------------------------------------------------------+
| Processes:                                                       GPU Memory |
|  GPU       PID   Type   Process name                             Usage      |
|=============================================================================|
|    6      7847      C   python                                     11615MiB |
|    7      6412      C   python                                      4219MiB |
|    8     36257      C   .../anaconda2/envs/bert-serving/bin/python 11615MiB |
|    9     17293      C   /home/xxx/.conda/envs/aspect/bin/python    11613MiB |
+-----------------------------------------------------------------------------+
```

解决 cuda10 因为显卡驱动不支持的

```bash
conda install cudatoolkit=9.0
```

用如下代码可检测tensorflow的能使用设备情况：

```python
from tensorflow.python.client import device_lib
print(device_lib.list_local_devices())　
```

## 4. CPU

Keras以及Tensorflow强制使用CPU

使用CUDA_VISIBLE_DEVICES命令行参数，代码如下：

```bash
CUDA_VISIBLE_DEVICES="" python3 train.py
```

## Reference

- [Anaconda介绍、安装及使用教程][2]
- [Tensorflow检验GPU是否安装成功 及 使用GPU训练注意事项][3]
- [报错：cudaGetDevice() failed. Status: CUDA driver version is][4]
- [https://tensorflow.google.cn/install/source][5]
- [tensorflow 使用CPU而不使用GPU的问题解决][6]
- [Keras以及Tensorflow强制使用CPU][7]

[1]: https://kexue.fm/archives/4765
[2]: https://zhuanlan.zhihu.com/p/32925500
[3]: https://www.cnblogs.com/nxf-rabbit75/p/10639833.html
[4]: https://blog.csdn.net/u010513327/article/details/81124110
[5]: https://tensorflow.google.cn/install/source
[6]: https://www.cnblogs.com/hutao722/p/9583214.html
[7]: https://blog.csdn.net/silent56_th/article/details/72628606
