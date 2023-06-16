

# redis missing pv
# 1. create volume manually, 20G enough, not attch to disk, copy id into below file
# 2. create pv
kubectl create --namespace pipelines -f pipelines-redis-pv.yaml
