BUILD_NAME=cli-ant-build
BUILD_NUMBER=15
BUILD_NUMBER_DIFF=14

curl -H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' \
-X GET "https://demo.jfrogchina.com/artifactory/api/build/$BUILD_NAME/$BUILD_NUMBER?diff=$BUILD_NUMBER_DIFF"
