# HTTPClient:HTTPClient:0.3-3
curl -X GET "https://demo.jfrogchina.com/artifactory/api/download/app1-maven-release-virtual/HTTPClient/HTTPClient/0.3-3/HTTPClient-0.3-3.jar?content=none" \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' 


# aopalliance:aopalliance:1.0
curl -X GET "https://demo.jfrogchina.com/artifactory/api/download/app1-maven-release-virtual/aopalliance/aopalliance/1.0/aopalliance-1.0.jar?content=none" \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' 

# fastjson
curl -X GET "https://demo.jfrogchina.com/artifactory/api/download/app1-maven-release-virtual/com/alibaba/fastjson/1.2.24/fastjson-1.2.24.jar?content=none" \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' 


curl -X GET "https://demo.jfrogchina.com/artifactory/api/download/app1-generic-dev-local/test.zip?content=none" \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' 

curl -X GET "https://demo.jfrogchina.com/artifactory/api/download/app1-generic-art-remote/org/artifactory/pro/jfrog-artifactory-pro/7.49.6/jfrog-artifactory-pro-7.49.6-linux.tar.gz?content=none" \
-H 'X-JFrog-Art-Api: '"$ART_API_KEY"'' 


# This is extremely useful if you want to trigger downloads on a remote Artifactory server,
#for example to force eager cache population of large artifacts

# content=none -> not download to client
# content=progress -> download to client

