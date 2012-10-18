
fs = require 'fs'
show = ->
path = require 'path'
mime = require 'mime'

# show __dirname
exports.read = (url, res) ->
  filepath = path.join __dirname, '../', url
  if fs.existsSync filepath
    file_content = fs.readFileSync filepath, 'utf8'
    res.writeHead 'content-type', (mime.lookup url)
    res.end file_content
  else
    res.writeHead 404
    res.end()