
# ./install_postgresql.sh
# ./install_nginx.sh

# helm repo add jfrog https://charts.jfrog.io 
# helm repo update

# read only
# helm fetch jfrog/pipelines --untar

# kubectl create namespace pipelines
# kubectl label nodes cn-xxx.54 app=pipelines

        # about podAntiAffinity
        # artifactory/edge(named artifactory-xxx) > app: artifactory, artifactory-nginx > no
        # pipelines > app: pipelines, pipelines-postgresql > node: pipelines, pipelines-rabbitmq > node: pipelines, pipelines-redis > no , pipelines-vault > node: pipelines
        # xray > app: xray, xray-rabbitmq > node: xray
        # distribution > app: distribution
        # insight > app: insight

# redis missing pv (0/4 nodes are available: 4 pod has unbound immediate PersistentVolumeClaims.)
./install_redis_pv.sh

# if helm created pg
# --set postgresql.true=true \
# --set postgresql.postgresqlPassword: xxxxxx \

# prepare keys
# vi ./pipelines/values-ingress-passwords.yaml
# master key = openssl rand -hex 32
# joinkey > art > admin > user management > settings > unlock!
# password = you define
# authToken = uuidgen | tr '[:upper:]' '[:lower:]'

# vi values-ingress.yaml

helm upgrade --install pipelines --namespace pipelines \
--set postgresql.enabled=false \
--set global.postgresql.host="xxxxxx" \
--set global.postgresql.port=5432 \
--set global.postgresql.database="xxxxxx" \
--set global.postgresql.user="xxxxxx" \
--set global.postgresql.password="xxxxxx" \
--set pipelines.masterKey="xxxxxx" \
--set pipelines.joinKey="xxxxxx" \
--set pipelines.authToken="xxxxxx" \
--set pipelines.serviceId="xxxxxx" \
--set pipelines.msg.uiUserPassword="xxxxxx" \
--set rabbitmq.auth.password="xxxxxx" \
-f values-ingress.yaml \
jfrog/pipelines

# ./check.sh

# change system.yaml requires set value in valus.yaml
# ./install_pipelines.sh



