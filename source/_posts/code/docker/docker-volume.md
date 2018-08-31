---
title: docker之路——数据卷轴
categories: road
date: 2018-08-31 14:04:57
updated: 2018-08-31 14:04:57
tags: docker
---

- [参考](#参考)
- [是什么](#是什么)
- [使用](#使用)
    - [挂载卷轴](#挂载卷轴)
    - [删除卷轴](#删除卷轴)
    - [使用卷轴](#使用卷轴)

<!-- more -->

## 参考

[理解Docker（8）：Docker 存储之卷（Volume） - SammyLiu - 博客园](https://www.cnblogs.com/sammyliu/p/5932996.html)
[Docker容器学习梳理--Volume数据卷使用 - 散尽浮华 - 博客园](https://www.cnblogs.com/kevingrace/p/6238195.html)

**关于文件覆盖**
[Docker数据持久之volume和bind mount - CSDN博客](https://blog.csdn.net/docerce/article/details/79265858)

[官方文档-docker volume create](https://docs.docker.com/engine/reference/commandline/volume_create/#extended-description)

## 是什么

在不使用数据卷轴的情况下，docker容器内的数据只存在于其生命周期内，且容器外部以及其他容器都无法访问，容器一旦删除数据也丢失了（除非commit一个新的镜像），因此会有散需求需要满足：
一是 容器之间共享数据，二是容器内数据的持久化，三是容器共享宿主机数据。为了解决这三个问题所以有了数据卷轴的概念，在下文的使用中的[使用卷轴](#使用卷轴)中会说明如何解决这两个问题。

## 使用

有两种使用方式，一个是docker run命令的`-v`参数，一个是dockerfile文件中的`VOLUME`E命令

>

```bash
$ docker run --help
-v, --volume list                    Bind mount a volume  
    --volume-driver string           Optional volume driver for the container  
    --volumes-from list              Mount volumes from the specified container(s)
```

### 挂载卷轴

**-v 方式挂载**

`-v [host-dir]:container-dir:[rw|wo]`

如果指定`host-dir`,那么就会挂载指定的目录到容器中的目录上，并且会覆盖容器中指定目录的内容。
如果不指定`host-dir`,那么会在系统的`/var/lib/docker/volumes`目录下生成一个目录挂载到容器内。
可以通过`docker inspect container-id`来查看挂载情况

**VOLUME方式挂载**

在编写dockerfile文件时可以通过`VOLUME dir`的方式去挂载一个卷轴，这种方式与使用-v但是不指定`host-dir`是相同的

### 删除卷轴

Volume只有在下列情况下才能被自动删除：

- 该容器是用`docker rm －v`命令来删除的（-v是必不可少的）。
- docker run中使用了`--rm`参数

即使用以上两种命令，也只能删除没有容器连接的Volume。**连接到用户指定主机目录的Volume永远不会被docker删除**。即通过`-v host-dir:container-dir`明确指定主机目录的情况下，是不会删除主机上的文件的
如果你没有使用上面两种方式去删除卷轴，那么通过`docker volume COMMAND`将可以删除僵尸卷轴

`docker volume rm VOLUME [VOLUME...]`删除指定的卷轴
`docker volume prune` 清理所有不使用的卷轴

```bash
$ docker volume --help
Usage: docker volume COMMAND

Manage volumes

Commands:
  create      Create a volume
  inspect     Display detailed information on one or more volumes
  ls          List volumes
  prune       Remove all unused local volumes
  rm          Remove one or more volumes
```

**正如前面所说使用`-v host-dir:container-dir`指定的卷轴不会被删除，而且也不会出现在volume卷轴管理中，即通过`docker volume ls`命令是看不到这种方式创造的卷轴的**

docker volume命令是在后来的版本中引入的新功能，它除了可以管理所有的卷轴外（除了明确指定主机目录的卷轴），还可以独立的去创建一个卷轴，这样可以方便的在多个容器之间共享卷轴

### 使用卷轴

卷轴的目的是为了解决前文提出的三个问题，那么我们这里一一说明

**数据持久化以及共享宿主机数据场景**

我们通过`-v host-dir:container-dir`的方式将主机上的一个目录映射到容器内，这样对container-dir目录的所有操作就是对主机host-dir目录的操作，容器删除后该目录的数据仍然存在。
这样便解决了数据持久化问题，以及宿主机和容器共享数据问题。

**容器之间共享数据场景**

docker run命令中可以通过`--volumes-from`参数来共享其他容器或卷轴的数据

一种方式是
`docker run --volumes-from container-id`指定一个容器可以共享该容器中创建的卷轴，这里只是共享指定容器中创建的数据卷轴而不是共享容器的数据（目标容器运行与否无关）.

还有一种更优雅的方式则是通过`docker volume`命令

```bash
#https://docs.docker.com/engine/reference/commandline/volume_create/#extended-description
$ docker volume create hello

hello

$ docker run -d -v hello:/world busybox ls /world
```

**⚠️通过`docker volime`命令创建的卷轴在删除容器时即使加了`-v`参数(`docker rm -v container-id`)也不会删除卷轴**
