
path = require 'path'
marked = require 'marked'
show = ->
willow = require 'willow'

marked.setOptions {
  gfm: yes
  sanitize: yes
}

exports.markup = (file, url) ->
  extname = path.extname url
  if extname in ['.md', '.markdown']
    ret = marked file
    # show ret
    ret
  else if extname in ['.wl', '.willow']
    ret =  willow.willow file
    ret
  else file