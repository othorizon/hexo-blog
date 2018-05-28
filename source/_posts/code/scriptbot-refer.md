---
title: scriptbot脚本批处理程序开发 - 参考资料
categories: code
tags: [code,scriptbot]
date: 2018-05-17 17:57:57
updated: 2018-05-17 17:57:57
keywords: 基于spring boot的web项目开发,
description: scriptbot是一个采用sring boot框架开发的脚本批处理工具
---

本文是scriptbot项目开发中的参考资料

## 相关文章

[**scriptbot脚本批处理程序开发**](/code/scriptbot/)

<!-- more -->

---

[cookie的path值的默认规则](https://blog.csdn.net/YECHWNG/article/details/45558677/)
当cookie的path设置了值不为null的时候，以设置的值为准。
当cookie的path为null时候，获取请求的URI的path值 
当URI的path值是以“/”结尾的时候，直接设置为cookie的path值
当URI的path值不是以“/”结尾的时候，查看path里面是否有“/” 
如果有“/”的话，直接截取到最后一个“/”，然后设置为cookie的path值。
如果没有“/”的话，将cookie的path设置为”/”。

## 前端

### 零碎

**_.debounce**
_.debounce 用于限制函数的访问频率，在Underscore和loadash库中均有。
[浅谈 Underscore.js 中 _.throttle 和 _.debounce](https://blog.coding.net/blog/the-difference-between-throttle-and-debounce-in-underscorejs)

```html
<!-- 一个在vue中监控变量值变化的例子 -->
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>
<script src="https://cdn.bootcss.com/underscore.js/1.9.0/underscore-min.js"></script>
<div id="app">
    <input v-model="question">
</div>
<script>
var vm = new Vue({
      el: '#app',
      data: {
      question: ""
      });
var log=_.debounce(function () {
    console.log("changed");
   },500);
vm.$watch('question', function() {
    console.log('wating');
  log();
});
</script>
```

---

**js中的箭头函数和匿名函数：**
以`this`为例子，
对于普通函数（包括匿名函数），this指的是直接的调用者，在非严格模式下，如果没有直接调用者，this指的是window。
箭头函数是没有自己的this，在它内部使用的this是由它定义的宿主对象决定。
[Vue实例里this的使用](https://majing.io/posts/10000005341170)

{% blockquote vue官方文档 https://cn.vuejs.org/v2/guide/instance.html#实例生命周期钩子 %}
不要在选项属性或回调上使用箭头函数，比如 `created: () => console.log(this.a)` 或 `vm.$watch('a', newValue => this.myMethod())`。因为箭头函数是和父级上下文绑定在一起的，this 不会是如你所预期的 Vue 实例，经常导致 Uncaught TypeError: Cannot read property of undefined 或 Uncaught TypeError: this.myMethod is not a function 之类的错误。
{% endblockquote %}

### 跨域请求 携带cookie

[Angularjs之如何在跨域请求中传输Cookie](https://blog.csdn.net/mygrilzhuyulin/article/details/52690129)
[跨域Ajax请求时是否带Cookie的设置 - CSDN博客](https://blog.csdn.net/wzl002/article/details/51441704)
[解决cookie跨域访问 - 小眼儿 - 博客园](https://www.cnblogs.com/hujunzheng/p/5744755.html)
**服务器端 Access-Control-Allow-Credentials = true时，参数Access-Control-Allow-Origin 的值不能为 '*'**

### js css 前端特效动画

#### 特效站点

[网页特效库-html5 css3动画-banner特效-jquery特效代码](http://www.5iweb.com.cn/)
[CircularProgressButton](https://tympanus.net/Tutorials/CircularProgressButton/)
[Tutorialzine](https://tutorialzine.com/)

[Shape Shifter-文字粒子特效-支持各种命令的粒子特效](http://www.kennethcachia.com/shape-shifter/)

**impress.js 可以制作出类似prezi.com中的一张大图的幻灯片效果**
[impress/impress.js](https://github.com/impress/impress.js)

### 前端工具

#### 资料

[入门Webpack，看这篇就够了](https://www.jianshu.com/p/42e11515c10f)
[入门 Webpack，看这篇就够了 - 前端学习笔记 - SegmentFault 思否](https://segmentfault.com/a/1190000006178770)

---

- node , 是javascript语言的环境和平台，
- npm , bower, yarn 是一类，包管理，
- webpack , browserify , rollup是一类，javascript模块打包方案(方案+工具+插件)，
- babel , 编译(compiler)下一代的ES语法的插件- requirejs , seajs , 是一类, 基于commonjs，amd，cmd，umd 之类的模块类包加载方案的框架，
- grunt , gulp , 前端工具，结合插件，合并、压缩、编译 sass/less，browser 自动载入资源，
- react , angular , vue , backbone , 是一类，mvc , mvvm , mvp 之类的前端框架，
- jquery , zepto , prototype , 是一类，前端 DOM , BOM 类库 ，
- ext , yui , kissy , dojo , 是一类，前端应用组件，
- lodash , underscore , 函数式编程库。

来源：https://www.zhihu.com/question/37694275/answer/113609266

---

## 后端

### Spring boot 定时任务

[SpringBoot定时任务及Cron表达式详解](https://blog.csdn.net/ninifengs/article/details/77141240)

fixedDelay和fixedRate区别：
fixedDelay 在上一次执行结束后，等待xx毫秒后执行下一次
fixedRate 每间隔xx毫秒执行下一次任务，如果到了下一个任务执行的时间但是上一个任务还未结束，那么上一个任务结束后立即执行该次任务。

```cron crontab表达式
// spring的 表达式与linux的有所不同
秒：可出现", - * /"四个字符，有效范围为0-59的整数
分：可出现", - * /"四个字符，有效范围为0-59的整数
时：可出现", - * /"四个字符，有效范围为0-23的整数
每月第几天：可出现", - * / ? L W C"八个字符，有效范围为0-31的整数
月：可出现", - * /"四个字符，有效范围为1-12的整数或JAN-DEC
星期：可出现", - * / ? L C #"四个字符，有效范围为1-7的整数或SUN-SAT两个范围。1表示星期天，2表示星期一， 依次类推

"0 0 * * * *"                      表示每小时0分0秒执行一次
" */10 * * * * *"                 表示每10秒执行一次
"0 0 8-10 * * *"                 表示每天8，9，10点执行
"0 0/30 8-10 * * *"            表示每天8点到10点，每半小时执行
"0 0 9-17 * * MON-FRI"     表示每周一至周五，9点到17点的0分0秒执行
"0 0 0 25 12 ?"                  表示每年圣诞节（12月25日）0时0分0秒执行
```