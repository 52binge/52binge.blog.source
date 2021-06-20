---
title: python 结构化您的工程
date: 2017-11-04 10:05:21
categories: python
tags: [python]
---

如何利用Python的特性来创造简洁、高效的代码。 “**结构化**” 意味着通过编写简洁的代码，使逻辑和依赖清晰.

<!--more-->

## 仓库的结构

在一个健康的开发周期中，代码风格，API设计和自动化是非常关键的。同样的，对于工程的 架构 ,仓库的结构也是关键的一部分。

当一个潜在的用户和贡献者登录到您的仓库页面时，他们会看到这些:

- 工程的名字
- 工程的描述
- 一系列的文件

> 拥有良好的布局，事半功倍。

## 仓库样例

```bash
README.rst
LICENSE
setup.py
requirements.txt
sample/__init__.py
sample/core.py
sample/helpers.py
docs/conf.py
docs/index.rst
tests/test_basic.py
tests/test_advanced.py
```

## License

除了源代码本身以外，这个毫无疑问是您仓库最重要的一部分。在这个文件中要有完整的许可说明和授权。

如果您不太清楚您应该使用哪种许可方式，请查看 choosealicense.com.

## Setup.py

...

## Reference

- [结构化你的工程][1]

[1]: http://pythonguidecn.readthedocs.io/zh/latest/writing/structure.html