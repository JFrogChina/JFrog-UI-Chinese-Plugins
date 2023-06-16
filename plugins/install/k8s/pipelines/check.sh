

# kubectl get namespaces --show-labels
# kubectl get namespaces/pipelines -o yaml

# pv
# kubectl get PersistentVolumeClaim -n pipelines
# redis-data-pipelines-redis-master-0 pedning ...
# kubectl describe pods/pipelines-redis-master-0 -n pipelines

# pod
kubectl get pods -n pipelines

# kubectl describe pods/pipelines-pipelines-services-0 -n pipelines
# kubectl logs pods/pipelines-pipelines-services-0 -n pipelines



