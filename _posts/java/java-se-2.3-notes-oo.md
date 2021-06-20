
---
title: Java SE Learning Notes for OO
date: 2013-07-24 13:54:16
tags: [java]
categories: java
---

Java SE `面向对象`部分的概要笔记: `手中无剑`, `心中有剑`.

定义类  生成对象  ， 定义方法  被调用 

<!-- more --> 

## 1. static

`static var` 知道了内存，你就知道了一切.  

- 局部变量 分配在 **stack** memory
- 成员变量 分配在 **heap** memory

`static var` 为类对象共享的变量 在数据区  

- 非静态变量 专属于某一个对象  
- 静态方法不再是针对某一个对象进行调用, 所以不能访问非静态成员。  

## 2. package
 
包名起名方法 ： 公司域名倒过来.
      
- 必须保证该类 class 文件位于正确的目录下.  
- 必须class文件的最上层包的父目录位于classpath下.  
- 执行一个类需要写全包名.  

**SDK 主要的包介绍**  

    * java.lang - 包含一些 java 语言的核心类， 如 : String, Math, Integer, System, Thread.  
    * java.net  - 包含执行与网络相关的操作的类  
    * java.io   - 包含能提供多种输入/输出功能的类  
    * java.util - 包含一些实用工具类.  
    
## 3. 类的继承与权限控制

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

 
## 4. Abstract class  

 - abstract 修饰class时，这个类叫做抽象类.
 - abstract 修饰方法时，该方法叫做抽象方法.
 - abstract class 必须被继承，抽象方法必须被重写. 含有抽象方法的类必须声明为抽象类.
 - abstract class 不能被实例化, 抽象方法只需声明，而不需要实现.
 
## 5. Final 关键字  

- final 的变量的值不能够被改变. final 的成员变量、局部变量(形参)
- final 的方法不能够被重写， final 的类不能够被继承.
 
- 系统中的 final class 例如： 
        
      public final class String  
      public final class Math  
      public final class Boolean

## 6. interface: 一种特殊的抽象类

- 变量全是: public static final int id = 1;
- 方法全是: abstract function()  
     
* java.lang - Comparable 我看就像 cmp 一样！(个人认为)  
                  Interface Comparable<T> 可以扩展  
- **interface** **interface** 可以相互继承  
- **class** **interface** 只能是 implement 关系  

## Reference

- [csdn robbyo java][1]            
                    
[1]: http://blog.csdn.net/robbyo/article/category/1328994/14