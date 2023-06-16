curl -X POST "https://demo.jfrogchina.com/artifactory/api/docker/docker-dev-local/v2/promote" \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' \
-H "Content-Type: application/json" \
--data-raw '{
    "dockerRepository": "hello-world",
    "tag": "v1",
    "targetRepo" : "docker-prod-local",
    "copy": true
}'

# do not copy from online document
# docker promote has no release history