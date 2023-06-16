
# 1. by api for docker, pancheng: upload to local will not update catalog in real time?
curl -X GET "https://demo.jfrogchina.com/artifactory/api/docker/app1-docker-dev-local/v2/_catalog" \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"''


# 2. by search api
# curl -X GET "https://demo.jfrogchina.com/artifactory/api/search/artifact?name=*manifest.json&repos=app1-docker-dev-local" \
# -H "X-Result-Detail: info" \
# -H 'X-JFrog-Art-Api: '"$ART_API_KEY"''

# 3. by search pattern, not work
# curl -X GET "https://demo.jfrogchina.com/artifactory/api/search/pattern?pattern=app1-docker-dev-local:*" \
# -H 'X-JFrog-Art-Api: '"$ART_API_KEY"''


# 4. by aql, check 6_find_docker.png

