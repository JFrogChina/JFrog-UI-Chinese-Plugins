

# helm repo add jfrog https://charts.jfrog.io 
# helm repo update
# helm fetch jfrog/artifactory --untar

# kubectl label nodes cn-xxx.xx app=artifactory

# install with command example

# aws EFS
helm upgrade --install artifactory --namespace artifatory \
--set initContainers.resources.requests.cpu="10m" \
--set initContainers.resources.limits.cpu="250m" \
--set initContainers.resources.requests.memory="64Mi" \
--set initContainers.resources.limits.memory="128Mi" \
--set serviceAccount.create=false \
--set rbac.create=false \
--set artifactory.service.pool=all \
--set artifactory.masterKey="FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF" \
--set artifactory.joinKey="xxx" \
--set artifactory.persistence.storageClassName="gp2" \
--set artifactory.persistence.size="100Gi" \
--set artifactory.database.maxOpenConnections=700 \
--set artifactory.tomcat.connector.maxThreads=1500 \
--set access.database.maxOpenConnections=300 \
--set access.tomcat.connector.maxThreads=500 \
--set metadata.database.maxOpenConnections=200 \
--set postgresql.enabled=false \
--set database.type="postgresql" \
--set database.driver="org.postgresql.Driver" \
--set database.url="jdbc:postgresql://xxx.rds.amazonaws.com:5432/artifatory" \
--set database.user="xxx" \
--set database.password="xxx" \
--set nginx.enabled="true" \
--set nginx.https.enabled="false" \
--set nginx.service.type="NodePort" \
--set nginx.service.nodePort="30082" \
--set nginx.http.internalPort="30082" \
--set nginx.http.externalPort="30082" \
--set nginx.resources.requests.cpu="1" \
--set nginx.resources.limits.cpu="4" \
--set nginx.resources.requests.memory="1Gi" \
--set nginx.resources.limits.memory="8Gi" \
--set nginx.persistence.enabled=true \
--set nginx.persistence.storageClassName="gp2" \
--set nginx.persistence.size="50Gi" \
 jfrog/artifactory

# aws s3
# helm upgrade --install artifactory --namespace artifactory \
#   --set artifactory.masterKey=xxx \
#   --set artifactory.joinKey=xxx \
#   --set artifactory.persistence.size=200Gi \
#   --set artifactory.persistence.type="aws-s3" \
#   --set artifactory.persistence.awsS3.endpoint="oss-cn-xxx.aliyuncs.com" \
#   --set artifactory.persistence.awsS3.bucketName="jfrog-artifactory" \
#   --set artifactory.persistence.awsS3.identity="xxx" \
#   --set artifactory.persistence.awsS3.credential="xxx" \
#   --set artifactory.persistence.awsS3.path="artifactory/filestore" \
#   --set artifactory.persistence.awsS3.httpsOnly=false \
#   --set artifactory.persistence.awsS3.testConnection=true \
#   --set postgresql.enabled=false \
#   --set database.type=postgresql \
#   --set database.driver=org.postgresql.Driver \
#   --set database.url="jdbc:postgresql://xxx.com:5432/artifactory" \
#   --set database.user=xxx \
#   --set database.password=xxx \
#   --set mc.enabled=true \
# jfrog/artifactory

# install with custom value
# helm upgrade --install artifactory --set mc.enabled=true --namespace artifactory jfrog/artifactory -f ./custom-artifactory.yaml

# system.yaml
# check values.yaml, 1) customInitContainers 2) systemYamlOverride existingSecret 3) default systemYaml in values.yaml

# binarystore.yaml
# check values.xml -> binarystoreXml




