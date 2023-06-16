# jfrog rt u --threads 2 "/Users/kyle/Downloads/tmp/large.war" app1-generic-dev-local/tmp/


SHELL_DIR=$(dirname "$BASH_SOURCE")
APP_DIR=$(cd $SHELL_DIR; pwd)
cd $APP_DIR


jf rt u "./lib/*" app1-generic-dev-local/xray-demo/ --recursive=false --flat=false

# file path will be app1-generic-dev-local/xray-demo/lib/xxx.jar



