# d4n-statsl-datapipeline 

Minimum Datalake stack

## 1. Minio 

```powershell
# move to minio folder
C:\>cd $Env:D4N_WORKSPACE_CODE\d4n-minio
# create the namespace
C:\>kubectl create namespace d4n-storage
# copy and edit the local config file
C:\>cp values.local.yaml config.yaml
# install or upgrade minio
C:\>helm upgrade --cleanup-on-fail --install minio  .  --namespace d4n-storage --values config.yaml
```

🛎️ If your are deploying on localhost docker-desktop k8s cluster
```powershell
# make it avaible at http://localhost:9001 on localhost docker-desktop k8s cluster
# for JupyterHub and Apache Nifi endpoint url, use: http://minio.d4n-storage.svc.cluster.local:9000
C:\>kubectl apply -f local-loadbalancer.yaml
```

🛎️ If your are deploying on the server
```powershell
# make it avaible at http://{master_ip_address}:309 on the server
# for JupyterHub and Apache Nifi endpoint url, use: http://minio.d4n-storage.svc.cluster.local:9000
C:\>kubectl apply -f proxy.nodeport.yaml --namespace d4n-storage
```

## 2. Jupyterlab


```powershell
## move to jupyterhub folder
C:\>cd $Env:D4N_WORKSPACE_CODE\d4n-jupyterhub
## load helm repository
C:\>helm repo add jupyterhub https://hub.jupyter.org/helm-chart/
C:\>helm repo update
## create the name space
C:\>kubectl create namespace d4n-analytics
## copy and edit the local config file 
C:\>cp values.local.yaml config.yaml
## install or upgrade the environement
C:\>helm upgrade --cleanup-on-fail --install jupyter jupyterhub/jupyterhub  --namespace d4n-analytics --version=3.0.3 --values config.yaml
```

🛎️ If your are deploying on localhost docker-desktop k8s cluster
```powershell
## make it avaible at http://localhost:8080 on localhost docker-desktop k8s cluster
C:\>kubectl apply -f  local-loadbalancer.yaml
```

🛎️ If your are deploying on the server 
```powershell
## make it avaible at http://{master_ip_address}:30808 on the server
C:\>kubectl apply -f proxy.nodeport.yaml --namespace d4n-analytics
```

## 3. Apache Nifi

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
