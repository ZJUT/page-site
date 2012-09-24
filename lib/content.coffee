
fs = require 'fs'
jade = require 'jade'
show = ->
path = require 'path'
markup = require('./markup').markup

# show __dirname
dir = {}
page = {}

dir.path = path.join __dirname, '../self/jade/dir.jade'
dir.tmpl = fs.readFileSync dir.path, 'utf8'
dir.html = jade.compile dir.tmpl, pretty: yes

page.path = path.join __dirname, '../self/jade/page.jade'
page.tmpl = fs.readFileSync page.path, 'utf8'
page.html = jade.compile page.tmpl, pretty: yes

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
  # show ret
  ret[1..]

index_files = (files, url) ->
  dirname = path.dirname url
  ret = []
  files.forEach (item) ->
    link = path.join dirname, item
    # show 'compare:: ', url, item
    if (path.basename url) is item then ret.push text: item
    else ret.push url: link, text: item
  ret

index_children = (url) ->
  file_path = path.join __dirname, '../', url
  ret = []
  children = fs.readdirSync file_path
  children.forEach (item) ->
    ret.push url: (path.join url, item), text: item
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
      obj.children = index_children url
      res.writeHead ''
      res.end (dir.html obj)
    else
      text = fs.readFileSync file_path, 'utf8'
      # show obj, file_path
      obj.html = markup text, url
      res.writeHead 200, 'content-type': 'text/html'
      res.end (page.html obj)