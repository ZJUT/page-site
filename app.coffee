
http = require 'http'
content = require './lib/content'
source = require './lib/source'
index = require './lib/index'
show = ->

app = http.createServer (req, res) ->
  if req.url is '/'
    index.read res
  else if req.url[..5] is '/self/'
    source.read req.url, res
  else if req.url in ['/page', '/page/']
    index.read res
  else if req.url[..5] is '/page/'
    content.read req.url, res
  else
    show 301
    res.writeHead 301, Location: 'http://localhost:3000'
    res.end()

app.listen 3000