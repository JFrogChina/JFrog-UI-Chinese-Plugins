curl -X POST "https://demo.jfrogchina.com/artifactory/api/search/buildArtifacts" \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' \
-H "Content-Type: application/json" \
--data-raw '{
    "buildName": "kyle-demo",
    "buildNumber": "100"
}'
