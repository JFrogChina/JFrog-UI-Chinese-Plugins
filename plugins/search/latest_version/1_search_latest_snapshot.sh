curl -X GET "https://demo.jfrogchina.com/artifactory/api/search/latestVersion?g=org.jfrog.test&a=multi3&repos=app1-maven-snapshot-local&v=4.7-SNAPSHOT" \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' 


# by specifying v=4.7-SNAPSHOT, this gets the latest one
# e.g. 4.7-20210314.144737-9