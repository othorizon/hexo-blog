---
title: git之路
categories: code
date: 2018-03-21 22:17:09
updated: 2018-06-01 11:59:20
tags: git
---

- [git配置多个远程仓库](#git配置多个远程仓库)
- [git的本地仓库和服务器仓库/裸库](#git的本地仓库和服务器仓库裸库)

<!-- more -->

## git配置多个远程仓库

**需求**
想要把项目同步备份到coding中一份，期望每次push代码时可以同步push到coding仓库中

**解决方案**

1. 在git仓库根目录执行
`git remote add --mirror=push coding git@git.coding.net:example/example.git`,添加一个镜像仓库，用来初始化镜像仓库数据或者pull镜像仓库数据时使用。
{% note info %}
对镜像仓库push数据时相当于执行`git push --mirror`，**会强制覆盖仓库中的数据** ，会以镜像的方式把包括所有分支和历史的commit提交到目标仓库
{% endnote %}
2. 执行
```bash
git remote set-url origin --push --add git@git.coding.net:example/example.git
git remote set-url origin --push --add git@github.com:example/example.git
```
 {% note info %}
**一定要把两个都设置上**:设置`origin`的pushurl为这两个远程仓库url，当设置了`pushurl`之后便不会再使用`url`作为默认的pushurl了，所以一定要把两个都设置上
{% endnote %}
3. 第一次设置后先执行`git push coding`把origin的代码镜像到coding仓库
4. 使用
 使用时修改文件之后只需要正常的执行`git push`便会向两个目标仓库都推送一遍。

```git git config
[remote "origin"]
        url = git@github.com:example/example.git
        fetch = +refs/heads/*:refs/remotes/origin/*
        pushurl = git@git.coding.net:example/example.git
        pushurl = git@github.com:example/example.git
[branch "master"]
        remote = origin
        merge = refs/heads/master
[remote "coding"]
        url = git@git.coding.net:example/example.git
        mirror = true
```

**另外**
不推荐在镜像仓库修改文件，但是如果真的在镜像仓库修改了文件而需要同步到原始仓库，那么先`git pull coding`获取镜像仓库的最新代码，然后`check out origin master` ,然后在merge代码过来。具体可以借鉴[Syncing a fork](https://help.github.com/articles/syncing-a-fork/)GitHub官网的fork代码同步的操作步骤，

**参考**
[git push如何至两个git仓库 - SegmentFault 思否](https://segmentfault.com/q/1010000000646988)
[准备更换git托管，如何迁移原git仓库 - SegmentFault 思否](https://segmentfault.com/q/1010000000124379)
[git本地仓库关联多个remote,怎么用本地一个分支向不同remote不同分支推送代码？ - 知乎](https://www.zhihu.com/question/46543115)

---

## git的本地仓库和服务器仓库/裸库

简单总结就是：
不加`--bare`参数得到的仓库（无论是`init`还是`clone`操作），是一个包含工作空间的仓库，可以修改工作空间内容后提交。
加`--bare`参数得到的是不包含工作空间的裸库，因此无法直接修改工作文件。一般是作为远端中心仓库或者说服务器仓库存在的。工作人员从该裸库clone到本地后进行工作然后提交到仓库。

参考：
[服务器上的 Git|git-scm](https://git-scm.com/book/zh/v1/%E6%9C%8D%E5%8A%A1%E5%99%A8%E4%B8%8A%E7%9A%84-Git)
[Git 本地仓库和裸仓库 - TaoBeier - SegmentFault 思否](https://segmentfault.com/a/1190000007686496)
[搭建Git服务器](https://www.liaoxuefeng.com/wiki/0013739516305929606dd18361248578c67b8067c8c017b000/00137583770360579bc4b458f044ce7afed3df579123eca000)

详解：
通过 `git init`命令可以创建一个本地仓库
本地仓库具备了git的版本控制，可以进行文件修改和`commit`仓库，
如果`git remote add origin [gitUrl]`之后还可以push到远程仓库，

而通过`git init --bare`则是创建的一个裸库
也可以理解为是服务器仓库，该仓库没有工作空间，也就是用户无法直接在该仓库编辑工作文件，只能通过clone下来后进行文件修改然后commit、push。
所以`git init --bare`是创建一个git服务器的过程，`git clone --bare [projectUrl] newProjectRepo`则是克隆一个仓库作为新的服务器仓库/裸库（没有工作空间的仓库）的操作，
测试`git clone [projectUrl] newProject`这样clone下来的是一个projectUrl的本地工作空间，