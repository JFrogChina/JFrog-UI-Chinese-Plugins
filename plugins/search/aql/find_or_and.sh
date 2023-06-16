
curl -X POST 'https://demo.jfrogchina.com/artifactory/api/search/aql' \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' \
-H 'Content-Type: text/plain' \
--data-raw 'items.find({
        "@build.name": {"$eq" : "cli-maven-build"},  
        "$or":[
            {
                "$and":[
                    {"@build.number": {"$eq" : "1"}}
                 ]
            },
            {
                "$and":[
                    {"@build.number": {"$eq" : "2"}}
                 ]
            }
          ]
}).include("artifact.module.build.number")'


