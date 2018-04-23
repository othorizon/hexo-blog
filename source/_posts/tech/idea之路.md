---
title: IntelliJ IDEA 之路
categories: tech
tags: [idea]
date: 2018-04-23 12:09:19
updated: 2018-04-23 12:09:19
keywords: idea,IntelliJ IDEA 设置
description:
---

![banner](https://ws4.sinaimg.cn/large/006tKfTcly1fqmlvuibdtj311q0b2jxw.jpg)

- [新特性](#新特性)
    - [2018.1](#20181)
        - [debug模式模拟抛出异常](#debug模式模拟抛出异常)
        - [http请求工具](#http请求工具)
        - [其他特性](#其他特性)

<!-- more -->
idea是博主最爱没有之一的开发工具，应该说jetbrains的开发工具都是非常棒的，idea的新特性在不停的增加，每次阅读更新日志都是一种享受像发现了新的玩具，2018年4月23这一天，本人决定开始记录idea使用过程中一些有价值的东西
有些更新的特性可能不是严格按照idea本身的版本来编排的，主要是按照博主本人发现这个特性的时间来编写,文档从2018年4月23开始编写，会逐步补充该时间之前的一些内容


# 新特性

## 2018.1

>IntelliJ IDEA 2018.1.1 (Ultimate Edition)
Build #IU-181.4445.78, built on April 10, 2018
macOS 10.13.4

[What’s New in IntelliJ IDEA](https://www.jetbrains.com/idea/whatsnew/#v2018-1-java)

### debug模式模拟抛出异常

可以在debug的断点位置模拟异常抛出，很实用
![DebuggerRaiseException](https://ws3.sinaimg.cn/large/006tKfTcly1fqmktifevjg315o0go7wh.gif)

Throw Exception
IntelliJ IDEA 2018.1 has a new Throw Exception action that allows you to throw an exception from a certain location in your program without changing the code. It is available from the Run | Throw Exception menu, or from the frame context menu during a debugging session.

### http请求工具

可以直接将@RequestMapping和@GetMapping注解的方法生成http请求
可以查阅示例文件(Tools|HTTP Client|Open HTTP Requests Collection)
[HTTP Client in IntelliJ IDEA Code Editor - Help | IntelliJ IDEA](https://www.jetbrains.com/help/idea/http-client-in-product-code-editor.html)
![SpringBootREST](https://ws4.sinaimg.cn/large/006tKfTcly1fqmkxtcalqg315o0go7k3.gif)
Access HTTP request mappings from the editor via the new REST client
Now, after you run a Spring Boot web application, a new icon is shown in the gutter for methods with @RequestMapping annotations that handle incoming HTTP requests. Click this gutter icon to open all the mappings in a scratch file with an .http extension and perform an HTTP request in the editor via the new REST client.

For methods with @GetMapping annotations, you have the choice to open the mapped URLs in a browser, or open a request in the HTTP Request Editor.

Note, that you need to add the dependency for the spring-boot-starter-actuator to your pom.xml or build.gradle file.

### 其他特性

代码可以按行提交了(git add -p)
![VCSPartialCommit1crop](https://www.jetbrains.com/idea/whatsnew/img/2018.1/VCSPartialCommit1crop.png)