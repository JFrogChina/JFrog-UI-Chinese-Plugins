
curl -X POST 'https://demo.jfrogchina.com/artifactory/api/search/aql' \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' \
-H 'Content-Type: text/plain' \
--data-raw 'items.find(
    {
        "repo": "app1-docker-dev-local",
        "name": {"$match": "*manifest.json" },
        "path": {"$nmatch": "*sha256__*"}
        
    }
).include("path")'