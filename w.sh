
cd `dirname $0`

echo '--- start watching'

node-dev app.coffee &
stylus -o _self/css -w _self/styl/global.styl &
# coffee -o _self/js -w _self/coffee/h.coffee &
doodle _self/css _self/js _self/jade &

read

pkill -f 'node-dev'
pkill -f 'stylus'
# pkill -f 'coffee'
pkill -f 'doodle'

echo '--- stop watching'
