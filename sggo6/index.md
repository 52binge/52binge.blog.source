## shop


```py
#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import numpy as np

def solve(map1, salary):

    res = []

    for key, value in map1.items():

        mean = np.mean(list(value))
        var = np.var(list(value))

        dis = abs(mean - salary)

        if len(res) == 0:
            res = [key, dis, var]
        else:
            if (dis < res[1]) or (dis == res[1] and var < res[2]):
                res[0] = key
                res[1] = dis
                res[2] = var

    if len(res) == 0:
        return "error!"

    return res[0]


def input_data():

    i = 0

    dict1 = {}

    for line in sys.stdin:

        a = line.split()

        title = str(a[0])
        salary = float(a[1])

        if (dict1.get(title) is None):
            dict1[title] = [salary]
        else:
            list1 = dict1[title]
            list1.append(salary)
            dict1[title] = list1

        i = i + 1
        if i == 3:
            return dict1
            break

if __name__ == '__main__':

    #dict1 = input_data()

    #print(dict1)

    dict1 = {'A': [2.0, 3.0, 4.0, 0.1], 'B': [3.0, 0.1], 'C': [3.0, 0.1]}

    title = solve(dict1, 3)

    print(title)
```

> [Python List Sort](http://www.runoob.com/python/att-list-sort.html)

> [python实现一个简易hashmap](https://www.jianshu.com/p/a4ff3d9d5776)
> 
> [Spark的调度流程—详细、易懂、面试](https://blog.csdn.net/BigData_Mining/article/details/80743921)

TCP/UDP

> 1. TCP、UDP 区别 
> 2. 输入url之后发生了什么 

> 引申： 
> DHCP 
> ARP 
> 三次握手 
> 长短连接 

> 3. IP是否有分组，TCP是否有分组，UDP是否有分组 

> 引申： 
> 选择重传和回退N步 
> 流量控制 
> 阻塞控制 
> IPV4和IPV6是否有分组 

> 4. 大小端 
> 5. TCP靠什么保证不丢包 
> 6. 找出1000万个单词中出现数量最多的k个，以及时间复杂度 
> 7. 32位系统大概有2^32约为4G的大小，为什么虚拟内存可以才2G 
> 8. 线程和进程 
> 9. 用什么来追踪用户状态 
> 10. 假如禁用了cookie，就不能使用session，那怎么来保持用户状态 
> 11. 父进程创建了一个新的子进程，它们所指的空间地址是否一样
