
curl -X POST 'https://demo.jfrogchina.com/artifactory/api/search/aql' \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' \
-H 'Content-Type: text/plain' \
--data-raw 'items.find(
    {
        "repo":"app1-maven-release-local",
        "path": {"$match" : "org/jfrog/test/*"},
        "name": {"$match" : "*4.7*"},
        "created" : {"$before" : "1d"}
    }
)'