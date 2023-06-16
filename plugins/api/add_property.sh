
appPath=app1-docker-dev-local/hello-world/latest/
curl -X PUT "https://demo.jfrogchina.com/artifactory/api/storage/${appPath}?properties=qa.test.api.total=10;qa.test.api.failed=1;qa.test.api.success=0.9&recursive=1"  \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' 

