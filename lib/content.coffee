
fs = require 'fs'
jade = require 'jade'
show = console.log
path = require 'path'

# show __dirname
layout = {}
page = {}

layout.path = '../self/jade/layout.jade'
layout.path = path.join __dirname, layout.path
layout.tmpl = fs.readFileSync layout.path, 'utf8'
layout.html = jade.compile layout.tmpl, pretty: yes

page.path = '../self/jade/page.jade'
page.path = path.join __dirname, page.path
page.tmpl = fs.readFileSync page.path, 'utf8'
page.html = jade.compile page.tmpl,
  pretty: yes, filename: './self/jade/layout'

index_files = (files, url) ->
  dirname = path.dirname url
  ret = []
  files.forEach (item) ->
    link = path.join dirname, item
    ret.push url: link, text: item
  ret

index_paths = (url) ->
  files = (url.split path.sep)[1...-1]
  # show files
  ret = []
  i = 0
  files.forEach (item) ->
    link = '/' + files[..i].join('/')
    show link
    ret.push url: link, text: item
    i += 1
  show ret
  ret

exports.read = (url, res) ->
  file_path = path.join __dirname, '../', url
  unless fs.existsSync file_path
    res.writeHead 404
    res.end "not found #{file_path}"
  else
    stat = fs.statSync file_path
    # show file_path
    files = fs.readdirSync (path.dirname file_path)

    obj =
      title: path.basename url
      paths: index_paths url
      files: index_files files, url

    if stat.isDirectory()
      obj.html = 'this is a derctory'
    else
      obj.html = fs.readFileSync file_path, 'utf8'

    res.writeHead ''
    res.end (html obj)