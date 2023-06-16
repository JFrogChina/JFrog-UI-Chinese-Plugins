
curl -X POST "https://demo.jfrogchina.com/artifactory/api/signed/url"  \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' \
-H "Content-Type: application/json" \
-d '{ "repo_path": "/app1-generic-dev-local/test.zip", "valid_for_secs":10000 }'
