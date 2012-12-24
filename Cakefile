
{print} = require "util"
{spawn} = require "child_process"

echo = (child) ->
  child.stderr.pipe process.stderr
  child.stdout.pipe process.stdout

make = (str) -> str.split " "
d = __dirname

queue = [
  "node-dev #{d}/app.coffee"
  "stylus -o #{d}/_self/css -w #{d}/_self/styl/global.styl"
  "doodle #{d}/_self/css _self/jade #{d}/collections/"
]

split = (str) -> str.split " "

task "dev", "watch and convert files", ->
  queue.map(split).forEach (array) ->
    echo (spawn array[0], array[1..])