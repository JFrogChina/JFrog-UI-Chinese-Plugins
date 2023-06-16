
# xray api, -ukyle:apikey
curl -ukyle:$ART_API_KEY \
-X POST "https://demo.jfrogchina.com/xray/api/v1/violations" \
-H "Content-Type: application/json" \
--data-raw '{
    "filters": {
        "name_contains": "fastjson",
        "violation_type": "Security",
        "watch_name": "repo-security-app1-maven-snapshot-local"
    },
    "pagination": {
        "order_by": "updated",
        "limit": 1000,
        "offset": 1
    }
}'
