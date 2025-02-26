# D4N-Apache-NiFi

```bash
# move to nifi folder
$cd d4n-apache-nifi
# load apache nifi application from helm repository
$helm repo add cetic https://cetic.github.io/helm-charts
$helm repo update
# copy from .local and edit the config file
$cp values.local.yaml config.yaml
# create the namespace 
$kubectl create namespace d4n-ingestion
# install or update apache nifi
$helm upgrade --cleanup-on-fail --install nifi cetic/nifi  --namespace d4n-ingestion --version=1.2.1 --values config.yaml
```

🛎️ If your are deploying on localhost docker-desktop k8s cluster
```bash
# make it avaible at https://localhost:8443 on localhost docker-desktop k8s cluster
$kubectl apply -f ../kubernetes-cluster/configs/local-loadbalancer.yaml
```

🛎️ If your are deploying on the server 
```bash
# make apache nifi available at https://{master_ip_address}:30443 on the server
$kubectl apply -f proxy.nodeport.yaml --namespace d4n-ingestion
```