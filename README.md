
Pages: 资源索引页面
------

* 部署网址:

http://pages.zjut.in/

* 当前部署方式:

```bash
# 网络可能用到 proxychains
git clone git@github.com:ZJUT/page-site.git # 事先添加 deploy key, 可能需要
cd page-site
npm install # 需要有 Node 环境, coffee-script 模块
forever start -c coffee app.coffee # 需要有 forever 模块
```

```nginx
server {
  listen 80;
  server_name pages.zjut.in;
  access_log /var/log/nginx/pages.log;
  error_log /var/log/nginx/pages-error.log;
  location / {
    autoindex_localtime on;
    proxy_set_header X-Real-IP $remote_addr;
    expires 1h;
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    # proxy_set_header X-NginX-Proxy true;
    proxy_pass http://127.0.0.1:3001;
    # proxy_redirect off;
  }
}
```

* 建议部署方式:

用 `supervisor` 替换 `forever`

* 功能:

文档的索引和标记, 用 Markdown 直接编辑, 再通过 Git 拉到服务器,  
Markdown 用 Marked 并且修正了换行

* 后台语言:

CoffeeScript
