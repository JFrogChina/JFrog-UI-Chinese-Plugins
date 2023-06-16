

jf c use art-mj

cd /Users/kyle/Downloads/mj/1-upload
# jf rt u "./*.nsp" app1-generic-dev-local/ --recursive=false --flat=false
jf rt u --threads 2 "./*.mp4" app1-generic-dev-local/ --recursive=false --flat=false --target-props="version=1.0.0;status=TO-TEST"

