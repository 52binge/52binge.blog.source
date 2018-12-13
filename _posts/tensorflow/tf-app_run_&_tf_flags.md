---
title: Tensorflow tf.app.run()与命令行参数解析
toc: true
date: 2018-10-23 13:10:21
categories: tensorflow
tags: tensorflow
---

tf.app.run() 与 命令行参数解析 tf.flags

<!-- more -->

首先给出一段常见的代码：

```python
if __name__ == '__main__':
    tf.app.run()
```

找到 Tensorflow 中关于上述 函数`run()` 的源码：

```python
def run(main=None, argv=None):
  """Runs the program with an optional 'main' function and 'argv' list."""
  f = flags.FLAGS

  # Extract the args from the optional `argv` list.
  args = argv[1:] if argv else None

  # Parse the known flags from that list, or from the command
  # line otherwise.
  # pylint: disable=protected-access
  flags_passthrough = f._parse_flags(args=args)
  # pylint: enable=protected-access

  main = main or _sys.modules['__main__'].main

  # Call the main function, passing through any arguments
  # to the final program.
  _sys.exit(main(_sys.argv[:1] + flags_passthrough))


_allowed_symbols = [
    'run',
    # Allowed submodule.
    'flags',
]

remove_undocumented(__name__, _allowed_symbols)
```

可以看到源码中的过程是首先加载 `flags` 的参数项，然后执行 `main` 函数。参数是使用`tf.app.flags.FLAGS` 定义的。

## tf.app.flags.FLAGS

关于 `tf.app.flags.FLAGS` 的使用：

```python
# fila_name: temp.py
import tensorflow as tf

FLAGS = tf.app.flags.FLAGS

tf.app.flags.DEFINE_string('string', 'train', 'This is a string')
tf.app.flags.DEFINE_float('learning_rate', 0.001, 'This is the rate in training')
tf.app.flags.DEFINE_boolean('flag', True, 'This is a flag')

print('string: ', FLAGS.string)
print('learning_rate: ', FLAGS.learning_rate)
print('flag: ', FLAGS.flag)
```

输出：

```bash
('string: ', 'train')
('learning_rate: ', 0.001)
('flag: ', True)
```

## Reference

- [tf.app.run()与命令行参数解析][1]
- [TensorFlow中的小知识：tf.flags.DEFINE_xxx()][2]
- [Tensorflow 1.0：老司机立下的Flag][3]
- [Tensorflow教程(十四) 命令行参数tf.flags的使用][4]

[1]: https://blog.csdn.net/TwT520Ly/article/details/79759448
[2]: https://blog.csdn.net/spring_willow/article/details/80111993
[3]: https://www.jianshu.com/p/7ccfe8cf4aa1
[4]: https://blog.csdn.net/yanqianglifei/article/details/83020992




