
---
title: Java SE Introduce
date: 2013-02-02 07:54:16
tags: [java]
categories: java
---

Java是一种广泛使用的计算机编程语言，拥有跨平台、面向对象、泛型编程的特性.

<!-- more -->

 - Java data type
 - OO
 - Exception
 - Java Array  
 - Java 常用类 
 - Java 容器类
 - Collection / Generic
 - Java I/O Stream
 - Java Thread
 - Java TCP/UDP, socket

## 1. Java 概述

 - Java 运行机制
 - JDK & JRE
 - Java env install
 - Java Basic Content

> conclude : 计算机语言朝着人类易于理解的方向发展  
       
  
## 2. Java 特点  
 
 - 一种 OO 语言  
 - 一种平台无关的语言, 提供程序运行的解释环境  
 - 一种健壮的语言, 吸收了C/C++语言的优点， 但去掉了其影响程序健壮性的部分(如: 指针， 内存的申请与释放等)。  
  
## 3. Java程序运行机制 

**Java 2种核心机制**

 - Java Virtual Machine
 - Garbage collection
 
> JVM 可理解成一个以字节码为机器指令的CPU  
> JVM 机制屏蔽了底层运行平台的差别, 实现了"一次编译, 随处运行"。
>                                            
> x.java --编译--> x.class --执行--> JVM
>
> Java语言消除了程序员回收无用内存空间的责任; 
> 它提供一种系统级线程跟踪存储空间的分配情况，并在JVM的空闲时, 检查并释放那些可被释放的存储器空间。  
 
## 4. JDK & JRE & env install

 - Software Development Kit (软件开发包)  开发需要 JDK  
 - Java Runtime Environment  用户只需 JRE  

``/etc/profile`` or  ``~/.zshrc`` or  ``~/.zprofile``

```      
### JAVA ###
JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_79.jdk/Contents/Home
JAVA_BIN=$JAVA_HOME/bin
PATH=$JAVA_HOME/bin:$PATH
CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/jre/lib/dt.jar:$JAVA_HOME/jre/lib/tools.jar
export JAVA_HOME JAVA_BIN PATH CLASSPATH
```

> classpath : java在编译和运行时要找的class所在的路径
> 建议你的 JDK 装在不带空格的目录里面


## 5. 命名规则

 1. 类名首字母大写  
 2. 变量名和方法名的首字母小写  
 3. 运用驼峰标识   

HelloWorld.java

```
public class HelloWorld {
  public static void main(String[] args) {
    System.out.println("Hello Java.");
  }
}
/**
  * 这里是注释
  */
```

> 一个源文件中最多只能有一个public类. 其它类的个数不限，如果源文件 文件包含一个public class 它必需按该 class-name 命名  

## 6. Java 程序设计

**data type**


```
                                          -- 整数类型 (byte, short, int, long)  
                              -- 数值型 --     
                             |            -- 浮点类型 (float, double)  
               --基本数据类型  -- 字符型 (char)  
              |              |  
              |               -- 布尔型 (boolean)  
    数据类型 --                           
              |               -- 类 (class)  
              |              |  
               --引用数据类型  -- 接口 (interface)  
                             |  
                              -- 数组 (array)
```
***

> java 中定义了 **4类 8种** 基本数据类型  
> boolean 类型只允许取值 true / false , 不可以用 0 或 非0 替代。  
> char 采用 Unicode 编码 (全球语言统一编码), 每个字符占两个字节  

## 7. Array & Method

```
public class Test {  
    public static void main(String[] args) {  
        Date[] days;  
        days = new Date[3];  
        for (int i = 0; i < 3; i++) {  
            days[i] = new Date(2004, 4, i+1);  
        }
        // 
        int[] a = {1, 2, 3, 4, 5, 6, 7};  
        for (int i = 0; i < a.length; i++) {  
            System.out.print(a[i] + " ");  
        }  
    }  
}  
class Date {  
    int year;  
    int month;  
    int day;  
    Date(int y, int m, int d) {  
        year = y;  
        month = m;  
        day = d;  
    }  
}
```

[面向过程-约瑟夫环](http://blog.csdn.net/robbyo/article/details/16942921)

[面向对象-约瑟夫环](http://blog.csdn.net/robbyo/article/details/16967715)
