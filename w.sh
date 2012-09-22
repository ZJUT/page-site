
cd `dirname $0`

echo '--- start watching'

node-dev app.coffee &
stylus -o self/css -w self/styl/global.styl &
stylus -o self/css -w self/styl/index.styl &
coffee -o self/js -w self/coffee/h.coffee &
doodle self/css self/js self/jade &
jade -O self/html -w self/jade/index.jade &

read

pkill -f 'node-dev/wrapper.js app.coffee'
pkill -f 'stylus -o self/css -w self/styl/global.styl'
pkill -f 'stylus -o self/css -w self/styl/index.styl'
pkill -f 'coffee -o self/js -w self/coffee/h.coffee'
pkill -f 'doodle self/css self/js self/jade'
pkill -f 'jade -O self/html -w self/jade/index.jade'

echo '--- stop watching'