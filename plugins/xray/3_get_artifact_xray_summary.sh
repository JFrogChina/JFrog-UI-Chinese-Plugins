
# xray api
# 1. uses username:apikey e.g. -ukyle:apikey
# 2. use 8082

curl -ukyle:$ART_API_KEY \
-X POST "https://demo.jfrogchina.com/xray/api/v1/summary/artifact" \
-H "Content-Type: application/json" \
--data-raw '{
    "paths": [
        "artifactory/app1-maven-release-local/org/jfrog/test/multi3/4.7/multi3-4.7.war"
    ]
}'

# scan jar
# "artifactory/xray-org-maven-central-remote-cache/com/alibaba/fastjson/1.2.24/fastjson-1.2.24.jar"

# check https://demo.jfrogchina.com/ui/repos/tree/Xray/xray-org-maven-central-remote-cache%2Fcom%2Falibaba%2Ffastjson%2F1.2.24%2Ffastjson-1.2.24.jar
# if Artifact doesn't exist or not indexed/cached in Xray
# manually trigger the indexing, then it will work
# https://demo.jfrogchina.com/ui/admin/xray/general/indexed_resources
