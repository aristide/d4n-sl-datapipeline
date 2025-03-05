# D4N-Apache-NiFi

```powershell
# move to nifi folder
C:\>cd $Env:D4N_WORKSPACE_CODE\d4n-apache-nifi
# load apache nifi application from helm repository
C:\>helm repo add cetic https://cetic.github.io/helm-charts
C:\>helm repo update
# copy from .local and edit the config file
C:\>cp values.local.yaml config.yaml
# create the namespace 
C:\>kubectl create namespace d4n-ingestion
# install or update apache nifi
C:\>helm upgrade --cleanup-on-fail --install nifi cetic/nifi  --namespace d4n-ingestion --version=1.2.1 --values config.yaml
```

🛎️ If your are deploying on localhost docker-desktop k8s cluster
```powershell
# make it avaible at https://localhost:8443 on localhost docker-desktop k8s cluster
C:\>kubectl apply -f local-loadbalancer.yaml
```

🛎️ If your are deploying on the server 
```powershell
# make apache nifi available at https://{master_ip_address}:30443 on the server
C:\>kubectl apply -f proxy.nodeport.yaml --namespace d4n-ingestion
```