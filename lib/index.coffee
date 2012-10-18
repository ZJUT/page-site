
path = require 'path'
jade = require 'jade'
fs = require 'fs'
show = ->

page = {}
page.path = path.join __dirname, '../_self/jade/index.jade'
page.tmpl = fs.readFileSync page.path, 'utf8'
page.html = jade.compile page.tmpl, pretty: yes, filename: '_self/jade/layout.jade'

exports.read = (res) ->
  res.end page.html()