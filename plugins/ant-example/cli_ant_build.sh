BUILD_NAME=cli-ant-build
BUILD_NUMBER=15

# 收集依赖信息
jfrog rt bad $BUILD_NAME $BUILD_NUMBER "libs/"

# 上传制品
jfrog rt u "build/" app1-generic-dev-local/kyle/ --build-name=$BUILD_NAME --build-number=$BUILD_NUMBER
jfrog rt u "module1/*.zip" app1-generic-dev-local/kyle/module1/ --build-name $BUILD_NAME --build-number $BUILD_NUMBER --module m1

# 上传依赖信息
jfrog rt bp $BUILD_NAME $BUILD_NUMBER
