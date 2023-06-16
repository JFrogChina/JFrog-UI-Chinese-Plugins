
curl -X POST 'https://demo.jfrogchina.com/artifactory/api/search/aql' \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' \
-H 'Content-Type: text/plain' \
--data-raw 'builds.find(
    {
        "module.artifact.item.repo":"app1-maven-release-local",
        "module.dependency.name": {"$match" : "*fastjson*"}
    }
)'