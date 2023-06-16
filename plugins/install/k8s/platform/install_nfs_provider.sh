# option 1
helm repo add stable http://mirror.azure.cn/kubernetes/charts

helm install mynfs stable/nfs-client-provisioner  \
--set nfs.server=172.17.57.60 --set nfs.path=/data \
--set storageClass.defaultClass=true

# option 2
helm repo add apphub https://apphub.aliyuncs.com

helm install mynfs apphub/nfs-client-provisioner  \
--set nfs.server=172.17.57.60 --set nfs.path=/data \
--set storageClass.defaultClass=true

# option 3
yum install git -y
git clone https://github.com/kubernetes-incubator/external-storage.git --depth 1


