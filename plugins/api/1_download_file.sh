# download generic-local/tmp/file.txt
curl -X GET "https://demo.jfrogchina.com/artifactory/app1-generic-dev-local/M1.zip" --output M1.zip \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' 


# download libs-stage-local -> multi3-4.7.war
# curl -X GET "https://demo.jfrogchina.com/artifactory/libs-stage-local/org/jfrog/test/multi3/4.7/multi3-4.7.war" --output multi3-4.7.war \
# -H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' 

