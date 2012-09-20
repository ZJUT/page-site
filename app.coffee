
http = require 'http'
content = require './lib/content'
source = require './lib/source'
index = require './lib/index'
show = console.log

app = http.createServer (req, res) ->
  if req.url is '/'
    index.read res
  else if req.url[..5] is '/self/'
    source.read req.url, res
  else if req.url[..5] is '/page/'
    content.read req.url, res
  else if req.url is '/page'
    content.read req.url, res

app.listen 3000