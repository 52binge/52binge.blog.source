---
title: Pycharm Keyboard Shortcuts（Mac）
date: 2019-12-22 17:00:21
categories: python
tags: pyCharm
---

{% image "/images/python/tools/PyCharm_logo.jpg", width="500px", alt="Pycharm Keyboard Shortcuts" %}

<!-- more -->

## 1. Pycharm

No. | Shortcuts | Function
:----:  | :----: | :----: 
1. | Shift + option + Enter | auto import
2. | CMD + Opt + t | try/catch
| |
1 | **CMD + B** | 跳转到声明处（cmd加鼠标）
2 | CMD + [] | 光标之前/后的位置
3 | **SHIFT + CMD + F** , 全局搜索 | ✔️
4 | CMD + R **/** SHIFT + CMD + R | 当前文件替换 / 全局替换
5 | CMD + L , 指定行数跳转 | ✔️
6 | SHIFT + ENTER , 直接到下一行 | ✔️
7 | ALT + ENTER , auto-import | ✔️
| |
8 | CMD +/- **/** SHIFT CMD +/- | 展开当前 / 展开所有
| |
9 | OPT + CMD + l | 代码块对齐
10 | CMD + D | 在下一行复制本行的内容
 已熟练 | - | -
1 | CMD / | 注释/取消注释一行
2 | CMD + X/C | 复制光标当前行,剪切同理
3 | CMD + F | 当前文件搜索（回车下一个 shift回车上一个）
4 | CMD + F6 | 更改变量
结构性 | |
1 | CMD + O **/** SHIFT + CMD + O **/** OPT + CMD + O| 搜索 class / files / 符号（函数等) 
2 | CTR + Tab | 史上最NB的导航窗口 <br> 1. 工程 file 列表、文件结构列表 <br> 2. 命令行模式、代码检查、VCS等
3 | ALT + F12 打开命令行栏 | ✔️
4 | CMD + F12 显示文件结构 | ✔️
5 | CMD + J | 代码智能补全
6 | ALT + F1 | 定位编辑文件所在位置

## 2. Invoke Learning

```bash
PYTHONUNBUFFERED=1;
INTERMEDIATE_DATA_PATH=/Users/blair/ghome/6E/work_project/mlar/tmp;
PYTHONPATH=~/ghome/6E/work_project/mlar:~/ghome/6E/work_project/mlar/nn_framework
```

### environment

{% image "/images/python/tools/PyCharm_invoke.png", width="800px", alt="Pycharm Invoke" %}

## Reference

- [代码编辑快捷键][1]

[1]: https://blog.csdn.net/Haiyang_Duan/article/details/79078167
