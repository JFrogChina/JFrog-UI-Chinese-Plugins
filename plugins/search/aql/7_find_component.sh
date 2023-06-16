
curl -X POST 'https://demo.jfrogchina.com/artifactory/api/search/aql' \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' \
-H 'Content-Type: text/plain' \
--data-raw 'items.find(
    {
        "repo":"app1-maven-central-remote-cache",
        "name": {"$match" : "*log4j-core*"}
    }
)'