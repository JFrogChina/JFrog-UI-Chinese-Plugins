REPORT_ID=43

curl -ukyle:$ART_API_KEY \
-X POST "https://demo.jfrogchina.com/xray/api/v1/reports/vulnerabilities/$REPORT_ID?direction=desc&page_num=1&num_of_rows=1000&order_by=cvss3"

# error, no rows

# fix, manually trigger repo indexing
# https://demo.jfrogchina.com/ui/admin/xray/general/indexed_resources