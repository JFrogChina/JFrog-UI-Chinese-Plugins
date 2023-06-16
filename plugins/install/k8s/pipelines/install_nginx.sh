


# helm upgrade --install ingress-nginx ingress-nginx \
#   --repo https://kubernetes.github.io/ingress-nginx \
#   --namespace ingress-nginx --create-namespace

# - error
# xxx exist
# uninstall it

# - error
# cannot download
# Error response from daemon: Get https://k8s.gcr.io/v2/

# helm pull ingress-nginx/ingress-nginx
# or download chart from https://github.com/kubernetes/ingress-nginx/releases/tag/helm-chart-4.1.3

# - slow, but finally ok
# docker login demo.jfrogchina.com
# docker pull demo.jfrogchina.com/app1-docker-k8s-remote/ingress-nginx/controller:v1.2.1 - ok
# docker pull demo.jfrogchina.com/app1-docker-k8s-remote/ingress-nginx/kube-webhook-certgen:v1.1.1 - ok
# docker pull demo.jfrogchina.com/app1-docker-k8s-remote/defaultbackend-amd64:1.5 - ok

# - works some time later, for some of below images ...
# docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/nginx-ingress-controller:v1.2.1 - ok (path is not ingress-nginx/controller:v1.2.1)
# docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/ingress-nginx/kube-webhook-certgen:v1.1.1
# docker pull registry.cn-hangzhou.aliyuncs.com/google_containers/defaultbackend-amd64:1.5

# - download in background
# nohup sh -c "echo demo.jfrogchina.com/app1-docker-k8s-remote/ingress-nginx/kube-webhook-certgen:v1.1.1 | xargs -P10 -n1 docker pull" </dev/null >nohup.out 2>nohup.err &

# helm install ingress-nginx ./ingress-nginx --namespace ingress-nginx --create-namespace


# 1. add selector for kube-webhook-certgen in values.yaml
# 2. --set nodeSelector for other 2 pod
helm install ingress-nginx ./ingress-nginx --namespace ingress-nginx --create-namespace \
--set controller.nodeSelector.app=pipelines
