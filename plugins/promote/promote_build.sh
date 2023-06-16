curl -X POST "https://demo.jfrogchina.com/artifactory/api/build/promote/cli-maven-build/2" \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' \
-H "Content-Type: application/json" \
--data-raw '{
    "status": "staged",
    "sourceRepo" : "app1-maven-release-local",
    "targetRepo" : "app1-maven-prod-local",
    "copy": true
}'

# do not copy from online document