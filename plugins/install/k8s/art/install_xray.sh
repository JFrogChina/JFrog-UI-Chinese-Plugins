helm repo add jfrog https://charts.jfrog.io && helm repo update

helm upgrade --install xray --namespace xray \
--set common.persistence.storageClass="gp2" \
--set common.persistence.size="200Gi" \
--set postgresql.enabled="false" \
--set database.url="postgres://xxx.rds.amazonaws.com:5432/xray?sslmode=disable" \
--set database.user="xxx" \
--set database.password="xxx" \
--set xray.jfrogUrl="http://xxx:31941" \
--set xray.masterKey="FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF" \
--set xray.joinKey="xxx" \
--set rabbitmq.enabled="true" \
--set rabbitmq.auth.username="xray" \
--set rabbitmq.auth.password="xxx" \
--set rabbitmq.persistence.enabled=true \
--set rabbitmq.persistence.storageClass="gp2" \
--set rabbitmq.persistence.size="50Gi" \
--set rabbitmq.replicaCount=1 \
--set replicaCount=1 \
 jfrog/xray
