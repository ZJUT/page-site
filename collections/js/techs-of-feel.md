
## Feel 电台用到的一些前端技术

录播的音频, mp3 文件的播放, 用的是 SoundManager2
http://www.schillmania.com/projects/soundmanager2/
对于浏览器的兼容性是不错的, IE 下是回滚到 Flash 播放
因此部署时 `.swf` 文件也是跟着 JS 类库要一起部署的
一个麻烦的是 Firefox 新版对旧版的 Flash 默认不启用,
但 Firefox 又不能直接放 `.mp3`, 当时没能解决

滚动条, 在 IE 下有一定的兼容性, 可以用
http://jamesflorentino.github.com/nanoScrollerJS/
按电台的意愿, 以后让滚动条一直显示, 直接有 API 的
以前我在用在 jQuery `slideToggle` 的 `div` 里, 有麻烦的地方

魅力主播的页面, 多张照片用 slider, 计划从下面选
http://chocoslider.alandawi.com.ar/index_en.html
http://workshop.rs/projects/coin-slider/
没有做测试, 等用的时候在对比一下那个合适, 现在先上

直播要用的 jwplayer, 也是基于 Flash 的
http://www.longtailvideo.com/jw-player/wizard/
调试在这篇文章里写过, 在办公室电脑上还有对应环境
http://pages.zjut.in/linux/feel/crtmpserver.md
具体没做, 待补充

用到的模块在 cdn 上有, 现在是 91 上有一些
http://cdn.zjut.in/bower/components/
日后会迁移到 94 上的 cdn.zjut.com , 待补充

另外主题定制功能需要本地缓存, 接触到一个, 待定
https://github.com/d0ugal/locache
