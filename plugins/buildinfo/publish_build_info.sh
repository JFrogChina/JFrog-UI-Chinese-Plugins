curl -X PUT "https://demo.jfrogchina.com/artifactory/api/build" \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' \
-H "Content-Type: application/json" --upload-file build_info.json
