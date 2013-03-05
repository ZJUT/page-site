
http = require 'http'
content = require './lib/content'
source = require './lib/source'
show = ->

app = http.createServer (req, res) ->
  # show 'req', req.url
  url = decodeURI req.url
  if url is '/'
    res.writeHead 301, location: '/index.md'
    res.end()
  else if url[..6] is '/_self/'
    source.read req.url, res
  else
    content.read url, res

app.listen 3001
