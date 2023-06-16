#!/bin/bash -e

if [ -z "$JFROG_DIR" ]; then
  readonly JFROG_DIR="/var/opt/jfrog/pipelines"
fi
readonly REQKICK_DIR="$JFROG_DIR/reqKick"
readonly EXECTEMPLATES_DIR="$REQKICK_DIR/node_modules/pipelines-core/execTemplates"
readonly EXTENSIONS_DIR="$JFROG_DIR/extensions"
readonly REQEXEC_DIR="$JFROG_DIR/reqExec"
readonly REPORTS_DIR="$JFROG_DIR/reports"
readonly NODEINIT_DIR="$JFROG_DIR/nodeInit"
readonly REQKICK_CONFIG_DIR="$JFROG_DIR/var/etc/reqKick"
readonly REQKICK_SERVICE_NAME="pipelines-reqKick"
readonly CUSTOM_CERTS_DIR="$JFROG_DIR/var/etc/security/keys/trusted"
readonly CUSTOM_CERTS_FILE_LOC="/etc/ssl/certs/ca-bundle.crt"

# 1. update api url
# export BUILDPLANE_RPM_DOWNLOAD_URL="https://pipelines-api.jfrogchina.com/v1/passthrough/artifacts/buildPlane-x86_64-CentOS_7.rpm"
export BUILDPLANE_RPM_DOWNLOAD_URL="http://x.x.x.x/pipelines/api/v1/passthrough/artifacts/buildPlane-x86_64-CentOS_7.rpm"
export NODE_OPERATING_SYSTEM="CentOS_7"
export NODE_ARCHITECTURE="x86_64"
export RUN_MODE="production"
export NODE_ID="1"
export PROJECT_ID="1"
export BUILD_PLANE_VERSION="1.20.3"
export PIPELINES_SHARED_ARTIFACTORY_BASEURLUI="http://x.x.x.x"

# 2. update api url
# export PIPELINES_CORE_SERVICES_API_EXTERNALURL="https://pipelines-api.jfrogchina.com/v1"
export PIPELINES_CORE_SERVICES_API_EXTERNALURL="http://x.x.x.x/pipelines/api/v1"
export CONFIGURE_NODE=false
export ENABLE_SWAP=false
export NO_VERIFY_SSL=false
export PIPELINES_CORE_PROXY_HTTPPROXY=""
export PIPELINES_CORE_PROXY_HTTPSPROXY=""
export PIPELINES_CORE_PROXY_NOPROXY=""
export BOOT_BUILD_AGENT=true
export INSECURE_DOCKER_REGISTRIES='["demo.jfrogchina.com"]'

# 3. update token, the auto generated token does not work, create one from art > profile > unlock > generate identity token
export PIPELINES_NODE_API_TOKEN='xxxxxx'
export NODE_POLLER_INTERVAL_MS=15000
export CUSTOM_CERTS_DATA=
export CUSTOM_CERTS_ENABLED=false

if ! command -v curl; then
  yum -y check-update
  yum install -y curl
fi

CURL_OPTS=""
if [ "$CUSTOM_CERTS_ENABLED" == true ]; then
  mkdir -p $CUSTOM_CERTS_DIR
  echo -e $CUSTOM_CERTS_DATA > $CUSTOM_CERTS_DIR/ca.crt
  cp $CUSTOM_CERTS_DIR/ca.crt /usr/share/pki/ca-trust-source/anchors/
  update-ca-trust extract
elif [ "$NO_VERIFY_SSL" == true ]; then
  CURL_OPTS="--insecure"
fi

response_code=$(curl -H "Authorization: Bearer $PIPELINES_NODE_API_TOKEN" -I $BUILDPLANE_RPM_DOWNLOAD_URL $CURL_OPTS -o /dev/null -w "%{http_code}" -s -L)
if [ "$response_code" != "200" ]; then
  echo "Unable to connect to $BUILDPLANE_RPM_DOWNLOAD_URL"
  echo "Response code: $response_code, exiting"
  exit 1
fi

curl -H "Authorization: Bearer $PIPELINES_NODE_API_TOKEN" $BUILDPLANE_RPM_DOWNLOAD_URL $CURL_OPTS --output buildPlane.rpm

rpm -i --prefix=$JFROG_DIR --force buildPlane.rpm

source $NODEINIT_DIR/$NODE_ARCHITECTURE/$NODE_OPERATING_SYSTEM/boot.sh

init_time=$(date -u +"%FT%TZ")
api_response_code=$(curl -s $CURL_OPTS -X PUT -H "Authorization: Bearer $PIPELINES_NODE_API_TOKEN" -H "Content-Type: application/json" -d '{"lastInitializedAt":"'$init_time'"}' $PIPELINES_CORE_SERVICES_API_EXTERNALURL"/nodes/"$NODE_ID -o -l -i -w "%{http_code}")
