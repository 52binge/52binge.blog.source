
---
title: Java SE Learning Notes for All
date: 2013-02-02 07:54:16
tags: [java]
categories: java
toc: true
---

这篇主要是记录了我学习 Java SE 的概要笔记: `手中无剑`, `心中有剑`, `摘花飞叶可以伤人`.

<!-- more -->

## 1. 环境配置

```bash
### JAVA ###
JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk/Contents/Home
JAVA_BIN=$JAVA_HOME/bin
PATH=$JAVA_HOME/bin:$PATH
CLASSPATH=.:$JAVA_HOME/jre/lib/rt.jar:$JAVA_HOME/jre/lib/dt.jar:$JAVA_HOME/jre/lib/tools.jar
export JAVA_HOME JAVA_BIN PATH CLASSPATH
```

## 2. 基础

分析设计 ：  

		 1. 这个东西有 哪些类  
		 2. 类的 属性和方法  
		 3. 类与类之间的关系  
		 4. 实现  

## 3. 面向对象

- 定义类  生成对象 
- 定义方法  被调用  

### 3.1 static

`static var` 知道了内存，你就知道了一切.  

- 局部变量 分配在 **stack** memory
- 成员变量 分配在 **heap** memory

`static var` 为类对象共享的变量 在数据区  

- 非静态变量 专属于某一个对象  
- 静态方法不再是针对某一个对象进行调用, 所以不能访问非静态成员。  

### 3.2 package
 
包名起名方法 ： 公司域名倒过来.
      
- 必须保证该类 class 文件位于正确的目录下.  
- 必须class文件的最上层包的父目录位于classpath下.  
- 执行一个类需要写全包名.  

**SDK 主要的包介绍**  

    * java.lang - 包含一些 java 语言的核心类， 如 : String, Math, Integer, System, Thread.  
    * java.net  - 包含执行与网络相关的操作的类  
    * java.io   - 包含能提供多种输入/输出功能的类  
    * java.util - 包含一些实用工具类.  
    
### 3.3 类的继承与权限控制

        * 修饰符      类内部     同一包内      子类     任何地方  
        * private      Yes  
        * default      Yes      Yes  
        * protected    Yes      Yes         Yes  
        * public       Yes      Yes         Yes       Yes    

> 分析内存 : 子类对象包含一个父类对象.
> 重写方法不能使用比被重写方法更严格的访问权限 -- 其实这和多态有关  

super 关键字  & 继承中的构造方法
  
        如果调用 super 必须写在构造方法的第一行  
        如果没调用，系统自动调用 super(), 如果没调，父类中又没写参数为空这个构造方法则出错。  

- Object 类

        instanceof 是一个操作符  
        equals方法 J2SDK 提供的一些类 如 String , Date 重写了Object 的 equals() 方法.  
  
- 对象转型 casting
  
	    * 一个基类的引用类型变量可以指向 “其子类的对象”。  
	    * 一个基类的引用不可以访问其子类新增加的成员  
	    * 可以使用 引用 变量 instanceof 类名 来判断该引用型变量所"指向"的对象是否属于该类或该类的子类。  
	    * upcasting / downcasting  
	   
	        内存分析 - 明白了内存你就明白了一切！  
	  
  
- 动态绑定, 池绑定, 多态
    
	   * 动态绑定的机制 是 实际类型 new 的是！  
	   * 深一点 -- 是对象内部有一个指针。。。。。。  
	   * 动态绑定的机制是 ： 实际类型，还是引用类型。是调用实际类型，不是引用类型。  
	   
	   * 实际地址才会绑定到那个方法上。 方法在  code segment  
	   * 只有在运行期间(不是在编译期间)，运行出对象来，才能判断调用哪一个。。。。  

> 这是面向对象核心中的核心。核心中的核心 ! 带来的莫大好处: 可扩展性达到了非常非常的极致好！
> 
> 多态总结:
>     
>    1. 要有**继承**  
>    2. 要有**重写**  
>    3. 父类引用指向子类对象  

 
### 3.4 Abstract class  

 - abstract 修饰class时，这个类叫做抽象类.
 - abstract 修饰方法时，该方法叫做抽象方法.
 - abstract class 必须被继承，抽象方法必须被重写. 含有抽象方法的类必须声明为抽象类.
 - abstract class 不能被实例化, 抽象方法只需声明，而不需要实现.
 
### 3.5 Final 关键字  

- final 的变量的值不能够被改变. final 的成员变量、局部变量(形参)
- final 的方法不能够被重写， final 的类不能够被继承.
 
- 系统中的 final class 例如： 
        
      public final class String  
      public final class Math  
      public final class Boolean

### 3.6 接口: 一种特殊的抽象类

- 变量全是: public static final int id = 1;
- 方法全是: abstract function()  
     
* java.lang - Comparable 我看就像 cmp 一样！(个人认为)  
                  Interface Comparable<T> 可以扩展  
- **interface** **interface** 可以相互继承  
- **class** **interface** 只能是 implement 关系  
                    
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
 
## 5. 数组 
    
  * 四维空间  
  int[] a, int a[];  
  内存分析 - 知道了内存你就明白了一切！  
  本来无一物 ： 何处装数组。  
  * 动态初始化  
  * 静态初始化 int a[] = {3, 9, 8}; 内部过程屏蔽掉啦！  
    
  ipconfig  
  ipconfig -all  这里 -all 就是命令行参数。  
    
  基础类型一般分配在栈上面！包装类，用于把基础类型包装成对象，则分配在堆上了。  
  例如 类 Double, Integer  
    
  约瑟夫环 - 面向过程 和 面向对象 写法  
    
  另一个比较精巧的算法 ： 用数组来模拟链表  
    算法和逻辑思维能力不是一朝一夕能完成的。  
  排序算法紧跟着的是 - 搜索算法  
    
  -------------------------------  
  你这里是通过对象square1调用的方法getsquare()  
    public static void main(String[] args){  
        getsquare(); //这里会出错  
    }  
    是的。其实main函数可以简单认为跟本类没什么关系，只是调用本类的  
    其它静态方法时不用写类名而已。所以，要调用其它非静态方法，都要  
    先实例化，就像别的类来调用一样。   
-------- 我有些懂啦！ 但还是不太懂，我能理解啦！ (个人理解)--------  
  
    二维数组 ： 可以看成以数组为元素的数组  
    * 数组的拷贝 {  
    }  
    大公司剥削人剥削得最厉害！  
  明白内存你就明白了一切！。。。  
    
  总结 {  
    * 数组内存的布局  
    * 常见算法  
  }  
}  
 
## 6. 常用类
    
本章内容 {  
    * 字符串相关类 (String, StringBuffer)  
    * 基本数据类型包装类  
    * Math类  
    * File类  
    * 枚举类  
      
    * java.lang.String 类代表不可变的字符序列  
      
        String s1 = "helo";  
        String s3 = "hello";  
        s1 == s3 true  
        字符串常量 - data seg 区  
        data segment 编译器有优化  
          
        如果是 new s1 == s3 false  
              s1.equals(s3) true  
        字符串你可以看成是一个字符数组！  
          
        String 类常用方法 {  
            * 静态重载方法 public static String valueOf(...)  
            * public String[] spllit(String regex)  
        }  
        String.valueOf(Object obj);  多态的存在  
        toString  
        java.lang.StringBuffer 代表可变的字符序列  
          
        * 基本数据类型包装类  
            基本数据 ： 栈  -> 包装 --> 堆上面  
            * 包装类 {  
                * 写程序要循序渐进方法  
            }  
        * Math 类 { java.lang.Math 其中方法的参数和返回值类型都为 double }  
        * File 类 { java.io.File 类代表系统文件名 (路径和文件名)   
                File 类的常见构造方法 ：  
                * public File(String pathname)     
                    以 pathname 为路径创建 File 对象, 如果 pathname 是相对路径，则默认的当前路径在系统属性 user.dir 中存储  
                * public File(String parent, String child)  
                * File 的静态属性 String separator 存储了当前系统的路径分隔符。  
                    原型 ： public static final String separator 但是事实上无论在哪 你写 / 都没有问题  
                      
                    注意 \ 在 java 里面是转义字符  
            }  
         * Enum - java.lang.Enum 枚举类型 {  
                1, 只能够取特定值中的一个   
                2, 使用 enum 关键字  
                3, 是 java.lang.Enum  
                4, 举例 ： TestEnum.java  
            }  
    总结~~~ API 和 金庸的书差不多！  
              
## 7. 容器
                   
    第七章 容器 {  
        * 容器的概念       -        数组是么， 当然是！  
        * 容器API  
        * Collection 接口  
        * Iterator 接口  
        * 增强的 for 循环  
        * Set 接口  
        * List接口 和 Comparable接口  
        * Collections 类  
        * Map 接口  
        * 自动打包 / 解包  
        * 泛型 (JDK1.5新增)  
        -----  
        * J2SDk 所提供的容器位于 java.util 包内。  
        * 容器API的类图如下图所示：  
        --------------------------------------------------  
          
          
        1136 1136 1136   --  一个图, 一个类, 三个知识点，六个接口  
              
               <<interface>>  
                Collection  
               /           \                        <<interface>>  
 <<interface>>      <<interface>>                 ^  
      Set                List                     |  
       ^                  ^                       |  
       |           _______|______                 |  
         HashSet   LinkedList    ArrayList          HashMap  
           
           
        1136  1136  1136  一个图, 一个类, 三个知识点，六个接口  
          
        ---------------------------------------------------  
           
           
        * Collection 接口 -- 定义了存取一组对象的方法, 其子接口 Set 和 List 分别定  
            义了存储方式。  
              
            * Set 中的数据对象没有顺序且不可以重复。  
            * List中的数据对象有顺序且可以重复  
              
        * Map 接口定义了存储 “键 (key) -- 值 (value) 映射"对"的方法。  
          
        Collection 方法举例  
            * 容器类对象在调用 remove, contains 等方法时需要比较对象是否相等  
                这会涉及到对象类型的 equals 方法和 hashCode 方法，对于自定义的  
                类型，需要要重写 equals 和 hashCode 方法以实现自定义的对象相等  
                规则。  
                *　注意 ： 相等的对象应该具有相等的 hashcodes  
            * ---  
            ArrayList 底层是一个数组  
哈哈哈哈哈 ： 装入的是对象，因为对象在堆上，栈里面的内容随时可能被清空！  
              
            hashCode 能直接定位到那个对象  
              
            toyreb  
              
            Iterator - 接口最小化原则  
            我这大管家在做操作的时候 ： 连主人做任何的操作都不让操作啦！因为 iterater 执行了锁定，谁也不让谁看！  
              
            JDK 1.5 增强的 for 循环  
              
        Set {  
            HashSet, TreeSet 一个以 hash 表实现， 一个以 树 结构实现  
        }  
        List {  
            Object set(int index, Object element)  
            int indexof(Object o);  
            int lastIndexof(Object o);  
        }  
*** 一个类 {  
    Collections  -- java.util.Collections 提供了一些静态方法实现了基于List容器的一些常用算法  
      
    例如 {  
        void sort(List)  
        ...  
        ...  
        ...  
    }  
    LinkedList -- 逆序的时候效率较 ArrayList 高！  
      
    对于 特定的 对象怎么确定谁大谁小。 {  
        对象间可以比较大小  
        通过 接口 只能看见对象的一点】  
        Comparable 接口  -- 所有可以实现排序的类 都实现了 Comparable 接口  
    }  
    public int compareTo(Object obj)  
      
    泛型规定 - 只能传 “猫”  
      
    vector / hashtable 以前遗留下来的。效率特别低  
      
      
    Map 接口 {  
        Map 接口的实现类有 HashMap 和 TreeMap 等。 {hashmap 用 hash表来实现， TreeMap 用二叉树来实现-红黑}  
        Map 类中存储的键 - 值对通过键来标识，所以键值不能重复。{  
            不能重复 ： 是equals()  
                                    equals() 太慢， 所以我们用 hashCode() 来比较  
                                }  
        }  
    JDK 1.5 之后 {  
        可以自动打包和解包  
# - Auto-boxing / unboxing  
        * 在合适的时机自动打包 , 解包  
            * 自动将基础类型转化为对象  
            * 自动将对象转换为基础类型  
        * TestMap2.java  
        }  
      
    示例练习 {  
        TestArgsWords.java  
    }  
JDK 1.5 泛型  
* 起因 ：  
    * JDK 1.4 以前类型不明确  
        * 装入集合类型都被当作 Object 对待, 从而失去自己的实际类型。  
        * 从集合中取出时往往需要转型, 效率低, 容易产生错误。  
* 解决办法 ：  
    * 在定义集合的时候同时定义集合中对象的类型  
    * 示例 ： BasicGeneric.java  
        * 可以在定义 Collection 的时候指定  
        * 也可以在循环时用 Iterator 指定  
* 好处 ：  
    * 增强程序的可读性和稳定性  
      
    什么时候可以指定自己的类型 ： 你看 API， 他跟你就可以跟  
* 总结 {  
    1136  
    * 一个图  
    * 一个类  
        * Collections  
  * 三个知识点  
    * For  
    * Generic  
    * Auto-boxing / unboxing  
  * 六个接口 {  
    1, Collection {  
        2, Set,   
        3, List  
    }  
    4, Map  
    5, Iterator  
    6, Comparable  
  }  

## 8. IO 流
      
    能帮助你建立文件，不能帮你建目录  
      
    读到内存区 -   
      
    * 转换流 {  
        中文 windos 编码 JBK  
        当前系统默认的 编码是 JBK  
        IOS8859_1 包含的所有西欧语言 --> 后来才推出 UniCode (国际标准化组织为了包含全球)  
        JBK   JB2312   JB18030  东方人自己的编码 - 国标码 - 就是汉字，你可以认为  
        日文，韩文 都有自己的编码  - 台湾有自己的 大五码  
        拉丁1， 2， 3， 4， 5. 6. 7. 8. 9 都同意啦！包括俄罗斯， 但是中文还不行 ---- > UniCode  
        FileOutputStream() 构造方法自己去查  
    * System.in {  
        System 类   --   in 是 InputStream 类型  
        public static final InputStream in   抽象类 类型，  又是父类引用指向子类对象  
        InputStreamReader isr = new InputStreamReader(System.in);  
        System.in -> 管道直接堆到黑窗口上  
        BufferedReader br = new BufferedReader(isr);  
          
        wait()   
        运行后 ： 等待在那 - 阻塞式的方法 很多   
        readLine() 有点特殊  
        其实是 System.in 比较特殊  -- 标准输入 - 等待着标准输入 {  
            你不输入 - 我可不就等着么，当然这个也叫做同步方法。  
            你不输入，我就不能干别的  
            同步式的  
        }  
          
    * 数据流 {  
        请你把 long 类型的数， 写到 --> 文件里面去  
        readUTF()  
        UTF8 比较省空间  
    }  
    * 打印流 {  
        System.out   
        out - public static final PrintStream  
        默认在我们的黑窗口输出  
        语言代表人的思维 - 能够促进人的思维  
        log4J 著名的日志开发包  
    }  
      
    * Object 流 {  
        把整个 Object 全部写入硬盘被  
        在 VC 上叫做系列化  
        存盘点。  
        挨着排的序列化  
        再一点一点读出来  
          
        Serializable 接口  --- 标记性的接口  
        transient int k = 15;  
        相当于这个 k 是透明的。在序列化的时候不给于考虑，读的时候读默认值。  
          
        * Serializable 接口  
        * Externalizable 接口  extends  Serializable   
    }  
}  
          