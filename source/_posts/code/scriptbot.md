---
title: scriptbot脚本批处理程序开发
categories: code
tags: [code,scriptbot]
date: 2018-05-17 17:57:57
updated: 2018-05-17 17:57:57
keywords: 基于spring boot的web项目开发,
description: scriptbot是一个采用sring boot框架开发的脚本批处理工具
---

ScriptBot 是一个采用sring boot框架开发的 脚本批处理工具，是博主开发的一个简单的自用工具
本文意在通过该项目来总结一些Spring boot的web项目的开发经验

## 相关文章

- [参考资料](/code/scriptbot-refer/)

<!-- more -->

---

## 前端开发

### 零碎

**TIPS**

- cookie必须设置过期时间，cookie如果再没有设置期限的条件下如果关闭本浏览器就会自动的清除掉了cookie的值了。

**如何让div成为背景层**

```html
<div style="position:absolute;z-index:-1;width: 100%;height: 100%" >
</div>
```

**判断一个变量是否存在，如果没有就给他一个初始值**

```javascript
var attr = attr || "";

function Foo(option) {
    var defaultValue = option || {};
}
Foo();
```

[AngularJS路由系列(2)--刷新、查看路由,路由事件和URL格式，获取路由参数，路由的Resolve](https://www.cnblogs.com/darrenji/p/4981505.html#a)

```javascript 刷新当前路由页面
//刷新当前路由页面
(function(){
    angular.module('app')
        .controller('HomeController',['dataService','notifier', '$route', '$log', HomeController]);
    function HomeController(dataService, notifier, $route, $log){
        var vm = this;
        vm.message = 'Welcome to School Buddy!';
        //重新刷新路由
        vm.refresh = function(){
            $route.reload();
        }
    }
}());
```