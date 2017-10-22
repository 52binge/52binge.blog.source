
---
title: SBT Hello
date: 2016-03-16 07:54:16
tags: [scala, sbt]
categories: scala
toc: true
list_number: false
---

 1. 什么是 SBT ?
 2. SBT 项目工程目录
 3. SBT 编译打包 Scala HelloWorld

<!--more-->

## 1. SBT, What?

SBT 是 Simple Build Tool 的简称. SBT 可以认为是 Scala 世界的 maven。

SBT的着迷特性，比如：

 1. DSL build构建, 并可混合构建 Java 和 Scala 项目；
 2. 通过触发执行 (trigger execution) 特性支持持续的编译与测试；
 3. 可以重用 Maven 或者 ivy的repository 进行依赖管理；
 4. 增量编译、并行任务等等...

## 2. Hello, SBT

一个极致简单的 Scala项目 （hello simple project）

hello/HelloWorld.scala

```scala
object HelloWorld {
    def main(args: Array[String]) {
        println("Hello, SBT")
    }
}
```

sbt run

```
➜  hello git:(master) ✗ sbt
[info] Set current project to hello (in build file:/Users/hp/ghome/Spark-Scala/hello/)
> run
[info] Updating {file:/Users/hp/ghome/Spark-Scala/hello/}hello...
[info] Resolving org.fusesource.jansi#jansi;1.4 ...
[info] Done updating.
[info] Compiling 1 Scala source to /Users/hp/ghome/Spark-Scala/hello/target/scala-2.10/classes...
[info] Running HelloWorld
Hello, SBT
[success] Total time: 3 s, completed 2016-3-17 9:38:44
>
```

## 3. SBT 项目工程结构详解

一个典型的SBT项目工程结构如下图所示：

![图片描述][1]

** build.sbt 详解 **

build.sbt 相当于 maven-pom.xml，它是build定义文件。 

SBT 运行 使用 2 种形式 的 build 定义文件，

 1. one, put your project's base directory，-- build.sbt， a simple build definition； 
 2. other one, put project directory，can Use Scala language, more expressive。

一个简单的build.sbt文件内容如下：

```scala
name := "hello"      // 项目名称

organization := "xxx.xxx.xxx"  // 组织名称

version := "0.0.1-SNAPSHOT"  // 版本号

scalaVersion := "2.9.2"   // 使用的Scala版本号


// 其它build定义

```
 name 和 version的定义是必须的，因为如果想生成jar包的话，这两个属性的值将作为jar包名称的一部分, 各行之间以空行分隔。
除了定义以上项目相关信息，我们还可以在build.sbt中添加项目依赖：

```
// 添加源代码编译或者运行期间使用的依赖
libraryDependencies += "ch.qos.logback" % "logback-core" % "1.0.0"

libraryDependencies += "ch.qos.logback" % "logback-classic" % "1.0.0"

// 或者

libraryDependencies ++= Seq(
                            "ch.qos.logback" % "logback-core" % "1.0.0",
                            "ch.qos.logback" % "logback-classic" % "1.0.0",
                            ...
                            )

// 添加测试代码编译或者运行期间使用的依赖
libraryDependencies ++= Seq("org.scalatest" %% "scalatest" % "1.8" % "test") 
```

当然， build.sbt文件中还可以定义很多东西，比如添加插件，声明额外的repository，声明各种编译参数等等

** project目录即相关文件介绍 **

project目录下的几个文件可以根据情况添加。

build.properties 文件声明使用的要使用哪个版本的SBT来编译当前项目， 最新的sbt boot launcher可以能够兼容编译所有0.10.x版本的SBT构建项目，比如如果我使用的是0.12版本的sbt，但却想用0.11.3版本的sbt来编译当前项目，则可以在build.properties文件中添加sbt.version=0.11.3来指定。

plugins.sbt 文件用来声明当前项目希望使用哪些插件来增强当前项目使用的sbt的功能，比如像assembly功能，清理ivy local cache功能，都有相应的sbt插件供使用， 要使用这些插件只需要在 plugins.sbt 中声明即可.

为了能够成功加载这些sbt插件，我们将他们的查找位置添加到resolovers当中.

** 其他 **

```shell
$ touch build.sbt
$ mkdir src
$ mkdir src/main
$ mkdir src/main/java
$ mkdir src/main/resources
$ mkdir src/main/scala
$ mkdir src/test
$ mkdir src/test/java
$ mkdir src/test/resources
$ mkdir src/test/scala
$ mkdir project
$ ...
```

可以使用giter8来自动化以上步骤.
giter8的更多信息可参考https://github.com//giter8.


## 4. SBT Cmd ##

 1. actions – 显示对当前工程可用的命令
 2. update – 下载依赖
 3. compile – 编译代码
 4. test – 运行测试代码
 5. package – 创建一个可发布的jar包
 6. publish-local – 把构建出来的jar包安装到本地的ivy缓存
 7. publish – 把jar包发布到远程仓库（如果配置了的话)

more cmd

 1. test-failed – 运行失败的spec
 2. test-quick – 运行所有失败的以及/或者是由依赖更新的spec
 3. clean-cache – 清除所有的sbt缓存。类似于sbt的clean命令
 4. clean-lib – 删除lib_managed下的所有内容

## 5. Scala HelloWorld

SBT Scala HelloWorld 具体请看 : <a href="https://github.com/blair1/language/tree/master/scala/ScalaWorld">Scala-Projects/HelloWorld</a>


➜  HelloWorld> sbt package

```shell
[info] Loading project definition from /Users/hp/spark/HelloWorld/project
[info] Set current project to HelloWorld (in build file:/Users/hp/spark/HelloWorld/)
[info] Packaging /Users/hp/spark/HelloWorld/target/scala-2.11/helloworld_2.11-0.0.1-SNAPSHOT.jar ...
[info] Done packaging.
[success] Total time: 1 s, completed 2016-3-17 9:05:44
```

➜  HelloWorld> sbt run

```shell
[info] Loading project definition from /Users/hp/spark/HelloWorld/project
[info] Set current project to HelloWorld (in build file:/Users/hp/spark/HelloWorld/)
[info] Running Hi
Hi!
[success] Total time: 1 s, completed 2016-3-17 9:07:43
```

## 6. Spark HelloWorld

Spark HelloWorld 具体请看 : <a href="https://github.com/blair1/hadoop-spark/tree/master/spark/HelloWorld">Spark-Projects/HelloWorld</a>


➜  HelloWorld> sbt compile
➜  HelloWorld> sbt package

```shell
$SPARK_HOME/bin/spark-submit \
  --class "HelloWorld" \
    target/scala-2.11/helloworld_2.11-1.0.jar
``` 
    
## 7. Referenced article ##

参考 : <a href="http://www.scala-sbt.org/0.13/docs/zh-cn/Getting-Started.html">scala-sbt.org/0.13/docs/zh-cn/Getting-Started.html</a>
参考 : <a href="https://github.com/CSUG/real_world_scala/blob/master/02_sbt.markdown">CSUG/real_world_scala/blob/master/02_sbt.markdown</a>
参考 : <a href="http://www.scala-sbt.org/0.13.1/docs/Getting-Started/Hello.html">scala-sbt.org/0.13.1/docs/Getting-Started</a>
参考 : <a href="http://article.yeeyan.org/view/442873/404261">译言网</a>


  [1]: https://segmentfault.com/img/bVtyRb
