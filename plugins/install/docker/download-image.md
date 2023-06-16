

- jfrog-xray-3.73.8-compose-images
docker pull releases-docker.jfrog.io/jfrog/xray-mongo:3.2.6
docker pull releases-docker.jfrog.io/jfrog/router:7.67.0
docker pull releases-docker.jfrog.io/jfrog/observability:1.13.3
docker pull releases-docker.jfrog.io/jfrog/xray-server:3.73.8
docker pull releases-docker.jfrog.io/jfrog/xray-indexer:3.73.8
docker pull releases-docker.jfrog.io/jfrog/xray-analysis:3.73.8
docker pull releases-docker.jfrog.io/jfrog/xray-persist:3.73.8
docker pull releases-docker.jfrog.io/jfrog/xray-rabbitmq:3.11.9-management

docker save -o 1.tar releases-docker.jfrog.io/jfrog/xray-mongo:3.2.6
docker save -o 2.tar releases-docker.jfrog.io/jfrog/router:7.67.0
docker save -o 3.tar releases-docker.jfrog.io/jfrog/observability:1.13.3
docker save -o 4.tar releases-docker.jfrog.io/jfrog/xray-server:3.73.8

docker save -o 5.tar releases-docker.jfrog.io/jfrog/xray-indexer:3.73.8
docker save -o 6.tar releases-docker.jfrog.io/jfrog/xray-analysis:3.73.8
docker save -o 7.tar releases-docker.jfrog.io/jfrog/xray-persist:3.73.8
docker save -o 8.tar releases-docker.jfrog.io/jfrog/xray-rabbitmq:3.11.9-management

docker load < 1.tar
docker load < 2.tar
docker load < 3.tar
docker load < 4.tar
docker load < 5.tar
docker load < 6.tar
docker load < 7.tar
docker load < 8.tar

