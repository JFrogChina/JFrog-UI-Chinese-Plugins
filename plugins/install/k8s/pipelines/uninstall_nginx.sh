





helm uninstall ingress-nginx ./ingress-nginx --namespace ingress-nginx
# helm uninstall ingress-nginx --namespace ingress-nginx https://kubernetes.github.io/ingress-nginx

# kubectl delete -A ValidatingWebhookConfiguration ingress-nginx-admission
kubectl delete job/ingress-nginx-admission-patch --namespace ingress-nginx

