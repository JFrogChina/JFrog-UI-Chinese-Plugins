
curl -X POST 'https://demo.jfrogchina.com/artifactory/api/search/aql' \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' \
-H 'Content-Type: text/plain' \
--data-raw 'items.find(
    {  
        "repo": {"$eq" : "app1-docker-dev-local"},
        "path": {"$match" : "hello-world/latest"},
        "@qa.test.api.success": {"$gte" : "0.5"}
    }
)'