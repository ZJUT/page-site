
## Supervisor 部署应用

网上搜了一遍, 部署应用跑到后台服务的有 supervisord, monit, upstart, runit 几种方案
monit 之前配置, 偏重监视.. 配置文件也比较简单
之前网上看到有推荐 supervisor, 所以用了 suprtvisor 试试看

原因是像 Node 程序跑起来是监听在端口, 一般就阻塞了命令行
我一般用 [forever][forever] 工具部署, 也可以参考 [github][forever-github]
如果挂了 forever 可以用守护进程重启, 但这在服务器重启时失效
于是需要增加一个系统服务级别的工具来启动应用, 虽然就重启...
另外 Python Ruby 也是监听端口跑进程的, 部署方式有相似

[forever]: http://blog.nodejitsu.com/keep-a-nodejs-server-up-with-forever
[forever-github]: https://github.com/nodejitsu/forever

## 介绍

supervisor 有用 [Sphinx 写的一大篇文档][sphinx], 想看都英文的
另外有一篇不错的[中文介绍][blog], 我是看这篇博客配的
[sphinx]: http://supervisord.org/
[blog]: http://codinn.com/people/brant/notes/110948/

配置文件以 `xxx.conf` 保存在 `/etc/supervisor/conf.d` 下
一个 Node 程序, `coffee` 命令启动的话, 我是这样配置的
```
[program:copyboard]
command=/usr/local/bin/coffee /home/cyong/s/copyboard/server.coffee
autorstart=true
autorrestart=true
stdout_logfile=/home/cyong/log/copyboard.log
```
最开始没成功, 遇到错误是 supervisor 修改完脚本要 update ..$^&%

## 部署 Go

Python 的 go.zjut.com 有 redis-server 和 gunicorn 两部分要跑
redis 不懂, gunicorn 问了是 Makefile 里这一个命令跑的
```
gunicorn -c ./confs/gunicorn.py turnav:app
```
在 [guncorn 的文档里有supervisor 配置的例子][gunicorn-supervisor], 照抄在下面
[gunicorn-supervisor]: http://docs.gunicorn.org/en/latest/deploy.html#supervisor

```
[program:gunicorn]
command=/path/to/gunicorn main:application -c /path/to/gunicorn.conf.py
directory=/path/to/project
user=nobody
autostart=true
autorestart=true
redirect_stderr=True
```
然后 go 的配置我是下面这样写的
```
[program:go]
command=/usr/local/bin/gunicorn turnav:app -c /opt/myZjutDeveloper/yaofur/projects/turkey-nav/confs/gunicorn.py
directory=/opt/myZjutDeveloper/yaofur/projects/turkey-nav
user=nobody
autostart=true
autorestart=true
redirect_stderr=True
```
然后用下面的命令去管理, 主要有 `update start stop restart`
```
sudo supervisorctl update
sudo supervisorctl start go
```

### 留神

重复安装 supervisor 遇到过个问题, 提示没有 `supervisord section`
看了一下, 我多了一个配置文件, 把其中空的一个删除了好了
```
/etc/supervisord.conf
/etc/supervisor/supervisord.conf
```
