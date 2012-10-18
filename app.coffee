
http = require 'http'
content = require './lib/content'
source = require './lib/source'
index = require './lib/index'
show = ->

app = http.createServer (req, res) ->
  # show 'req', req.url
  url = decodeURI req.url
  if url is '/'
    index.read res
  else if url[..6] is '/_self/'
    source.read req.url, res
  else if url is '/'
    index.read res
  else
    content.read url, res

app.listen 3001
