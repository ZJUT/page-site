
cd `dirname $0`

echo '--- start watching'

node-dev app.coffee &
stylus -o self/css -w self/styl/global.styl &
coffee -o self/js -w self/coffee/h.coffee &
doodle self/css self/js self/jade &

read

pkill -f 'node-dev/wrapper.js app.coffee'
pkill -f 'stylus -o self/css -w self/styl/global.styl'
pkill -f 'coffee -o self/js -w self/coffee/h.coffee'
pkill -f 'doodle self/css self/js self/jade'

echo '--- stop watching'