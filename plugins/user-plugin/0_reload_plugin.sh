
# 1. login primary node, place your plugin files under $JFROG_HOME/artifactory/var/etc/artifactory/plugins.
# 2. wait a few seconds till sync to all nodes from primary
# 3. call primary node api to reload plugin

curl -u admin:xxx \
-X POST "http://119.23.40.143:8082/artifactory/api/plugins/reload"

