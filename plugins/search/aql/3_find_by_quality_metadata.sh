
curl -X POST 'https://demo.jfrogchina.com/artifactory/api/search/aql' \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' \
-H 'Content-Type: text/plain' \
--data-raw 'items.find(
    {  
        "@build.name": {"$eq" : "kyle-demo"},  
        "repo": {"$eq" : "app1-maven-release-local"},
        "name": {"$match" : "multi3-*.war"},
        "@qa.test.api.success": {"$gte" : "0.5"}
    }
)'