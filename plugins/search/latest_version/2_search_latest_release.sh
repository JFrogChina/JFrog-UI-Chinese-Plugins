curl -X GET "https://demo.jfrogchina.com/artifactory/api/search/latestVersion?g=org.jfrog.test&a=multi3&repos=app1-maven-release-local" \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' 



# without specifying param v, this is getting release version, not snapshot
# e.g. 4.7
