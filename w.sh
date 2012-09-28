
cd `dirname $0`

echo '--- start watching'

node-dev app.coffee &
stylus -o self/css -w self/styl/global.styl &
stylus -o self/css -w self/styl/index.styl &
coffee -o self/js -w self/coffee/h.coffee &
doodle self/css self/js self/jade &
jade -O self/html -wP self/jade/index.jade &

read

pkill -f 'node-dev'
pkill -f 'stylus'
pkill -f 'coffe'
pkill -f 'doodle'
pkill -f 'jade'

echo '--- stop watching'
