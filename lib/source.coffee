
fs = require 'fs'
show = console.log
path = require 'path'

# show __dirname
exports.read = (url, res) ->
  filepath = path.join __dirname, '../', url
  if fs.existsSync filepath
    file_content = fs.readFileSync filepath, 'utf8'
    extname = path.extname url
    if extname is '.js'
      res.writeHead 200, 'Content-Type': 'text/javascript'
    else if extname is '.css'
      res.writeHead 200, 'Content-Type': 'text/css'
    res.end file_content
  else
    res.writeHead 404
    res.end()