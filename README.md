# hexo-blog

hexo建站的原始资料,网站工作空间
采用next主题

根目录的`assets`文件夹存放了一些原始资源文件

替换index模块为修改后的[sticky模块](https://github.com/othorizon/hexo-generator-index-sticky)，增加文章置顶功能

```bash
npm uninstall hexo-generator-index --save
npm install hexo-generator-index-sticky --save
```