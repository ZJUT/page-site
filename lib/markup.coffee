
path = require 'path'
marked = require 'marked'
marked.setOptions
  gfm: yes
  breaks: yes
show = ->
willow = require 'willow'

exports.markup = (file, url) ->
  extname = path.extname url
  if extname in ['.md', '.markdown', '.wl']
    ret = marked file
    # show ret
    ret
  else file