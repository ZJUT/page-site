
cd `dirname $0`
subl -a .

echo '--- start watching'

node-dev app.coffee &
stylus -o _self/css -w _self/styl/global.styl &
# coffee -o _self/js -w _self/coffee/h.coffee &
doodle _self/css _self/jade collections/ &

read

pkill -f 'node-dev'
pkill -f 'stylus'
# pkill -f 'coffee'
pkill -f 'doodle'

echo '--- stop watching'