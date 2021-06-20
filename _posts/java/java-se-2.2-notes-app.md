
---
title: Java SE Learning Notes for Hello World
date: 2013-02-02 10:54:16
tags: [java]
categories: java
---

第一个 Java 程序 HelloWorld.java.  `手中无剑`, `心中有剑`.

<!-- more -->

## Hello World

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

一个源文件中最多只能有一个public类. 如果源文件 文件包含一个public class 它必需按该 class_name 命名  

## Java 程序设计

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

> java 中定义了 **4类 8种** 基本数据类型  
> boolean 类型只允许取值 true / false , 不可以用 0 或 非0 替代。  
> char 采用 Unicode 编码 (全球语言统一编码), 每个字符占两个字节  

## Reference

