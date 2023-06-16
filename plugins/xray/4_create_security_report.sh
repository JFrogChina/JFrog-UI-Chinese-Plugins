
REPORT_NUMBER=5

curl -ukyle:$ART_API_KEY \
-X POST "https://demo.jfrogchina.com/xray/api/v1/reports/vulnerabilities" \
-H "Content-Type: application/json" \
--data-raw '{
 
    "name": "xray-project-repo-security-maven-report-'$REPORT_NUMBER'",
    "resources": {
        "repositories": [
            {
                "name": "xray-project-maven-release-local"
            },
            {
                "name": "xray-project-maven-snapshot-local"
            },
            {
                "name": "xray-project-maven-whitelist-local"
            }
        ] 
    }
 
}'