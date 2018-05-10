---
title: 巧妙的借助git快速批量转换crlf到lf
categories: tech
tags: []
date: 2018-05-11 03:16:11
updated: 2018-05-11 03:16:11
keywords: 转换crlf到lf
description: 批量转换crlf到lf
---

在windows和unix协同工作中，会遇到文件的换行符格式不一致的问题，windows采用的是`crlf`格式而unix采用的则是`lf`格式。
日常中大家使用git协同办公是没有问题的，这是因为git会转换这两种格式，所以如果遇到需要批量修改文件的编码格式问题时，可以借助git快速修改

autocrlf是git的一个配置
`git config core.autocrlf`
>autocrlf =true 表示要求git在提交时将crlf转换为lf，而在检出时将crlf转换为lf
autocrlf = false表示提交和检出代码时均不进行转换
autocrlf = input 表示在提交时将crlf转换为lf，而检出时不转换

因此我们只需要把需要转换的文件放入到一个文件夹里(work)，然后执行如下命令

```bash
cd $work
git init
git add .
git commit -m "init"
#删除所有文件，然后从git检出
rm -rf *
git reset --hard HEAD
```

就可以简单呢转换crlf到lf了。是不是很巧妙的方式