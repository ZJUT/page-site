
path = require 'path'
ghm = require 'github-flavored-markdown'
show = ->
willow = require 'willow'

exports.markup = (file, url) ->
  extname = path.extname url
  if extname in ['.md', '.markdown']
    ret = ghm.parse file
    # show ret
    ret
  else if extname in ['.wl', '.willow']
    ret =  willow.willow file
    ret
  else file