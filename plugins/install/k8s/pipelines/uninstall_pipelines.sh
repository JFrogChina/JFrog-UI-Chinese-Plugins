



# ignore message for below command - Error: uninstall: Release name is invalid: jfrog/pipelines
helm uninstall pipelines --namespace pipelines jfrog/pipelines 

# pvc
kubectl delete PersistentVolumeClaim/data-pipelines-postgresql-0 -n pipelines
kubectl delete PersistentVolumeClaim/data-pipelines-rabbitmq-0 -n pipelines
kubectl delete PersistentVolumeClaim/redis-data-pipelines-redis-master-0 -n pipelines

# pv, manualle created for redis will be gone, recreate it before reinstall
kubectl delete --namespace pipelines -f pipelines-redis-pv.yaml

# delete vault, otherwise reinstall pipelines will fail days after
# check pipelines-installer container's log, token expires
# kubectl delete secret/root-vault-secret -n pipelines
# kubectl delete secret/unlock-vault-secret -n pipelines

# do not delete valult, otherwise reinstall pipelines will fail
# error = CreateContainerConfigError / Error: secret "root-vault-secret" not found
# if deleted, need to delete database

