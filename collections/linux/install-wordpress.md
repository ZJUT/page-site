
测试服务器安装了一遍 wordpress 大概的记录:

从官方下载新版本的 wordpress: http://cn.wordpress.org/
之前直接到官网下载, 发现英文版没有默认转中文的选项, 懒得去找汉化插件
下载好用 `scp` 上传到服务器, 建立相应文件夹 `/opt/www/wordpressCyong`
把文件和以后上传的 `.zip` 上传到这里, 权限暂时是个人的...

`root` 登录 mysql 创建创建数据库和用户:
  create database wordpressCyong;
  grant all on wordpressCyong.* to cyong@localhost identified by 'cyong';
mysql 命令看手册啊看手册
http://www.360doc.com/content/10/0608/01/276520_31866098.shtml
并复制 nginx 以及 apache2 的配置, 修改对应 `ServerName` 和 `DocumentRoot`
然后重启 nginx 和 apache2...

修改配置文件, 填写对应数据库的账户名和密码..
  cp wp-config-sample.php wp-config.php
  vim wp-config.php
访问 http://wordpressCyong.zjut.in 安装
按说明填写密码, 马上安装成功...

这是访问首页有 `This webpage has a redirect loop` 错误
安装下面的插件来解决:
http://wordpress.org/extend/plugins/permalink-fix-disable-canonical-redirects-pack/
将插件上传到服务器, 解压放到 `wordpress/wp-content/plugins/`
然后从管理页面安装, 然后首页可以打开了

再安装主题到网上搜索 http://wordpress.org/extend/themes/
http://wordpress.org/extend/themes/patchwork
下载上传到服务器解压放到对应目录:
  mv patchwork wordpress/wp-content/themes/
从后台再选取对应主题, 刷新页面开采主题

然后文档.. 不想看, 太长了
http://codex.wordpress.org/zh-cn:Main_Page
