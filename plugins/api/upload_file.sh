curl -X PUT "https://demo.jfrogchina.com/artifactory/app1-generic-dev-local/tmp/file.txt" \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' \
-T ./myNewFile.txt
