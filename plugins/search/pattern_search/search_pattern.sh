curl -X GET "https://demo.jfrogchina.com/artifactory/api/search/pattern?pattern=app1-maven-release-local:org/jfrog/test/*/*/*.war" \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"''


# all * are necessary...