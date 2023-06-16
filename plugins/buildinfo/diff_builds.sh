BUILD_NAME=cli-maven-build
BUILD_NUMBER=2
BUILD_NUMBER_DIFF=1

curl -X GET "https://demo.jfrogchina.com/artifactory/api/build/$BUILD_NAME/$BUILD_NUMBER?diff=$BUILD_NUMBER_DIFF" \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' 

