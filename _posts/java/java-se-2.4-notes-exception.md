
---
title: Java SE Learning Notes for Exception
date: 2013-07-25 14:54:16
tags: [java]
categories: java
---

Java SE `异常处理`部分的概要笔记: `手中无剑`, `心中有剑`.

<!-- more --> 

## 第四章 异常处理  

* Java 异常是 Java 提供的用于处理程序中错误的一种机制。  
  java.lang....Exceptions  
  写程序有问题要有友好界面  
  医生开单子 {  
    1, 鼻腔内感觉异常  
    2, 体温持续升高  
    3, 分泌乳白色液体  
    直接说感冒不就得了么？  
  }  
  e.printStackTrace(); 非常好！给程序员读。堆栈信息都打印出来！  
    
  java.lang.Throwable { 开车在上山走，  
      1, Error         山爆发 JVM 出问题。  
      2, Exception {   你可以处理的 -- 刹车坏啦！修好再走。。。  
        1, ...  
        2, RuntimeException  (经常出，不用逮) 压路面上的小石子  
    }  
  一个 try 可以跟多个catch  
  所以 { 一个茶壶可以跟多个茶碗，一个男人可以三妻四妾。}  
  try {  
    // 可能抛出异常的语句  
    语句一；  
    语句二；  
  } catch(someEx e) {  
    语句；  
    }  
    catch() {  
        语句  
    }  
    finally {  
    }  
一 ： 打开  
二 ： 关闭  
finally : 一般进行资源的清除工作。。。！  
  
我处理不了的事情 ： 我交给上一级部门去处理！  
当时 catch 到 Ex 的时候，你至少要做出一种处理。要不那是危险的编程习惯！  
main() 抛出 就是交给 java 运行时系统啦！ 它会把堆栈信息打出来！  
  
一个图 ： 五个关键字 {  
    try, catch, finally, throw, throws  
}  
一点问题 {  
    先逮大的，后逮小的，报错。  
}  
使用自定义异常  
  
程序中可以使用 throw - 方法后 throws  
如果throw抛出异常之后,方法就结束啦！  
  
注意 ： 重写方法需要抛出与原方法所抛出异常类型一致异常或不抛出异常。  
  
* 总结 ：{  
     * 一个图  
     * 五个关键字  
     * 先逮小的，再逮大的。  
     * 异常与重写的关系  
}  
  

## Reference

- [csdn robbyo java][1]            
                    
[1]: http://blog.csdn.net/robbyo/article/category/1328994/14