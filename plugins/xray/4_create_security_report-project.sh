
REPORT_NUMBER=4

curl -ukyle:$ART_API_KEY \
-X POST "https://demo.jfrogchina.com/xray/api/v1/reports/vulnerabilities?projectKey=app1" \
-H "Content-Type: application/json" \
--data-raw '{
 
    "name": "kyle-report-'$REPORT_NUMBER'",
    "resources": {
        "repositories": [
            {
                "name": "app1-generic-dev-local"
            }
        ]
    }
 
}'


# generate report in project scope(appear in project' xray view)

