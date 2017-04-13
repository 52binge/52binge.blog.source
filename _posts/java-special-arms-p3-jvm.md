
---
title: JVM 跨平台与字节码原理初步
date: 2016-08-16 16:54:16
tags: [java,jvm]
categories: java
toc: true
list_number: false
description: Java特种兵 - JVM 跨平台与字节码原理，Reading Notes
---


用到 JVM 的场景

1. Out of memory 时，团队高手不在
2. 系统服务器架构，老大问你 投入多少服务器成本，VM 分配多大， 如何分配?


## 1. javap 命令

> 通过这种方式认知比 Java 更低一个抽象层次的逻辑，虚指令有时候更好解释问题。

```java
public class StringTest {
    public static void test1() {
        String a = "a" + "b" + 1;
        String b = "ab1";
        System.out.println(a == b); // true 编译时优化
    }
}
```

```bash
➜  p3jvm git:(master) ✗ pwd
/Users/hp/ghome/github/language/java/jsarms/p3jvm
➜  p3jvm git:(master) ✗ javac
Usage: javac <options> <source files>
where possible options include:
  -g                         Generate all debugging info
  -g:none                    Generate no debugging info
  -g:{lines,vars,source}     Generate only some debugging info
  -nowarn                    Generate no warnings
  -verbose                   Output messages about what the compiler is doing
```

```bash
➜  p3jvm git:(master) ✗ javac -g:vars,lines StringTest.java
➜  p3jvm git:(master) ✗ javap -verbose StringTest
Classfile /Users/hp/ghome/github/language/java/jsarms/p3jvm/StringTest.class
  Last modified Aug 16, 2016; size 559 bytes
  MD5 checksum 772d18512cb982c953e7db8c72522918
public class StringTest
  minor version: 0
  major version: 51
  flags: ACC_PUBLIC, ACC_SUPER
Constant pool:
   #1 = Methodref          #6.#21         //  java/lang/Object."<init>":()V
   #2 = String             #22            //  ab1
   #3 = Fieldref           #23.#24        //  java/lang/System.out:Ljava/io/PrintStream;
   #4 = Methodref          #25.#26        //  java/io/PrintStream.println:(Z)V
   #5 = Class              #27            //  StringTest
   #6 = Class              #28            //  java/lang/Object
   #7 = Utf8               <init>
   #8 = Utf8               ()V
   #9 = Utf8               Code
  #10 = Utf8               LineNumberTable
  #11 = Utf8               LocalVariableTable
  #12 = Utf8               this
  #13 = Utf8               LStringTest;
  #14 = Utf8               test1
  #15 = Utf8               a
  #16 = Utf8               Ljava/lang/String;
  #17 = Utf8               b
  #18 = Utf8               StackMapTable
  #19 = Class              #29            //  java/lang/String
  #20 = Class              #30            //  java/io/PrintStream
  #21 = NameAndType        #7:#8          //  "<init>":()V
  #22 = Utf8               ab1
  #23 = Class              #31            //  java/lang/System
  #24 = NameAndType        #32:#33        //  out:Ljava/io/PrintStream;
  #25 = Class              #30            //  java/io/PrintStream
  #26 = NameAndType        #34:#35        //  println:(Z)V
  #27 = Utf8               StringTest
  #28 = Utf8               java/lang/Object
  #29 = Utf8               java/lang/String
  #30 = Utf8               java/io/PrintStream
  #31 = Utf8               java/lang/System
  #32 = Utf8               out
  #33 = Utf8               Ljava/io/PrintStream;
  #34 = Utf8               println
  #35 = Utf8               (Z)V
// 以上是 Constant pool， 仅仅是陈列操作，并没有开始执行任务，看下面开始
{
  public StringTest();
    flags: ACC_PUBLIC
    Code:
      stack=1, locals=1, args_size=1 // 所有方法都会有。
      // stack 为栈顶的单位大小 (每个大小为 1 slot，4 byte)
      // locals=1，非静态方法，本地变量增加 this
         0: aload_0
         1: invokespecial #1                  // Method java/lang/Object."<init>":()V
         4: return
      LineNumberTable:
        line 1: 0
      LocalVariableTable:
        Start  Length  Slot  Name   Signature
               0       5     0  this   LStringTest;

  public static void test1();
    flags: ACC_PUBLIC, ACC_STATIC
    Code:
      stack=3, locals=2, args_size=0 
      // stack=3，本地栈slot个数为3，String需要load，String.out 占用一个再。当对比发生 boolean 时，两个String引用栈顶pop
      // locals=2， 因为只有两个 String
      // args_size=0，方法没有入口参数
         0: ldc           #2                  // String ab1
         // 引用常量池内容
         2: astore_0
         // 将栈顶引用值，写入第 1 个 slot 所在的本地变量
         3: ldc           #2                  // String ab1
         5: astore_1
         6: getstatic     #3                  // Field java/lang/System.out:Ljava/io/PrintStream;
         // 获取静态域，放入栈顶，此时静态域是 System.out 对象
         9: aload_0
        10: aload_1
        11: if_acmpne     18
        14: iconst_1
        15: goto          19
        18: iconst_0
        19: invokevirtual #4                  // Method java/io/PrintStream.println:(Z)V
        22: return
      LineNumberTable:
        line 4: 0
        line 5: 3
        line 6: 6
        line 7: 22
      LocalVariableTable:
        Start  Length  Slot  Name   Signature
               3      20     0     a   Ljava/lang/String;
               6      17     1     b   Ljava/lang/String;
      // 本地变量列表 LocalVariableTable. from javac -g:vars
      StackMapTable: number_of_entries = 2
           frame_type = 255 /* full_frame */
          offset_delta = 18
          locals = [ class java/lang/String, class java/lang/String ]
          stack = [ class java/io/PrintStream ]
           frame_type = 255 /* full_frame */
          offset_delta = 0
          locals = [ class java/lang/String, class java/lang/String ]
          stack = [ class java/io/PrintStream, int ]

}
➜  p3jvm git:(master) ✗
```

## 2. Java 字节码结构

javac 命令本身只是一个引导器，它引导编译器程序的运行。编译器本身是一个java程序 `com.sun.tools.javac.main.JavaCompiler`, 该类完成 java 源文件 的 Parser、Annotation process、检查、泛型处理、语法转换等，最终胜出 Class 文件。

Java 字节码文件主体结构: 

**Class 文件头部** |
------- | -------
Constant pool |
当前Clas的描述信息 |
属性列表 |
方法列表 |
... |