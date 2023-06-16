


# v6 ok to use api key

curl -X POST "http://demo.jfrogchina.com/artifactory/ui/artifactsearch/quick"  \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY_V6"'' \
-H 'Connection: keep-alive' \
-H 'Accept: application/json, text/plain, */*' \
-H 'X-Requested-With: XMLHttpRequest' \
-H 'User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/90.0.4430.85 Safari/537.36' \
-H 'Content-Type: application/json;charset=UTF-8' \
-H 'Origin: http://60.205.170.191:8082' \
--data-raw '{"search":"quick","query":"fastjson-1.2.24*"}'

