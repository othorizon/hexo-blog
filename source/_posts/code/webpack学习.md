---
title: webpack学习
categories: code
tags: [webpack]
date: 2018-05-29 20:21:40
updated: 2018-05-29 20:21:40
keywords:
description: webpack学习中遇到的问题
---

## tree shaking 不起作用

在跟着[官方demo](https://www.webpackjs.com/guides/tree-shaking)学习中tree shaking 没有起作用。
原因是本应该删除不用的导出的js文件在`webpack.config.js`的`entry`中作为入口配置了，因此没有处理。

_tree shaking_ 的意思是移除未被引用的代码。在webpack中想要起作用的条件是：
{% blockquote webpack官方指南 https://www.webpackjs.com/guides/tree-shaking/#结论 %}

1. 使用 ES2015 模块语法（即 import 和 export）。
2. 在项目 package.json 文件中，添加一个 "sideEffects" 入口。
3. 引入一个能够删除未引用代码(dead code)的压缩工具(minifier)（例如 UglifyJSPlugin）。

{% endblockquote %}

**对于第二条“sideEffects”入口**
还没完全研究明白，理解上大概是说通过import引入的模块，可以在模块的`package.json`中配置`sideEffects`来控制`副作用`，换言之 这个参数是加在通过npm安装的模块的package.json文件中。
可以查看[官方demo](https://github.com/webpack/webpack/tree/master/examples/side-effects)

{% blockquote Webpack4进阶 https://www.colabug.com/2641390.html %}
官方提供了sideEffects属性，通过将其设置为false，可以主动标识该类库中的文件只执行简单输出，并没有执行其他操作，可以放心shaking。除了可以减小bundle文件的体积，同时也能够提升打包速度。为了检查side effects，Webpack需要在打包的时候将所有的文件执行一遍。而在设置sideEffects之后，则可以跳过执行那些未被引用的文件，毕竟已经明确标识了“我是平民”。因此对于一些我们自己开发的库，设置sideEffects为false大有裨益
{% endblockquote %}

**对于第三条引入压缩工具**
只要在`webpack.config.js`配置文件中添加`mode: "production"`将模式设置为生产环境便会自动引入`UglifyJSPlugin`。
也可以在命令行接口中使用 `--optimize-minimize` 标记，来使用 UglifyJSPlugin

**另外**
webpack4中，对`mode`做了调整。`mode:"development"`时,将不进行tree-shaking和Scope hoisting，在使用production时才会进行这些操作。不设置mode默认为development

## 参考

[webpack学习中遇到的坑 - 糊里糊涂撸代码 - SegmentFault 思否](https://segmentfault.com/a/1190000013998339?utm_source=tag-newest/*&^%$)
