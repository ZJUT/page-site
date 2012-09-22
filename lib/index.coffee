
fs = require 'fs'
show = ->

exports.read = (res) ->
  fs.readFile 'self/html/index.html', 'utf8', (err, file) ->
    throw err if err?
    show file
    res.end file