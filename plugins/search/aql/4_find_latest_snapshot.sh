
curl -X POST 'https://demo.jfrogchina.com/artifactory/api/search/aql' \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' \
-H 'Content-Type: text/plain' \
--data-raw 'items.find(
    {  
        "repo": {"$eq" : "app1-maven-snapshot-local"},
        "name": {"$match" : "multi3-4.7-*.war"}
    }
).sort({"$desc" : ["name"]}).limit(1)'