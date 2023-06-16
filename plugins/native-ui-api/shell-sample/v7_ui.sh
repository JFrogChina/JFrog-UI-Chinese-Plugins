


# option1 - uses cookie

curl -X POST "https://demo.jfrogchina.com/ui/api/v1/ui/artifactsearch/quick"  \
-H "$ART_API_COOKIE_CE" \
-H 'Connection: keep-alive' \
-H 'Accept: application/json, text/plain, */*' \
-H 'X-Requested-With: XMLHttpRequest' \
-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'Origin: http://60.205.170.191:8082' \
--data-raw '{"query":"fastjson*","selectedRepositories":[],"search":"quick"}'

# option 2 - change url, then use api key auth (basic auth?)

# - V7 art

# # Before
# /ui/api/v1/users/permissions/test?userOnly=true

# # After
# /artifactory/ui/users/permissions/test?userOnly=true

# - V7 xray

# # Before
# /ui/api/v1/xray/ui/unified/watches/block-download-watch-lzw?jfLoader=true

# # After
# /xray/ui/unified/watches/block-download-watch-lzw?jfLoader=true

# - v6 ui api, still available in v7 for now

# # V6 Before
# /artifactory/ui/v1/native/versions/docker/docker-local

# # v7 After
# /artifactory/api/v1/native/versions/docker/docker-local