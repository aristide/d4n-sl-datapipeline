# Deployment of the Minimum Data Lake Stack from the Workstation

This section outlines the step-by-step procedure for deploying the essential components of a data lake, including MinIO for storage, JupyterHub for analytics, and Apache NiFi for data ingestion. The deployment is performed from the workstation onto a Kubernetes cluster.

## 1. Deploy MinIO (Storage)

```powershell
## Navigate to the MinIO deployment directory
C:\>cd $Env:D4N_WORKSPACE_CODE\d4n-minio
## Create a dedicated namespace for storage components
C:\>kubectl create namespace d4n-storage
## Copy the local configuration file and edit it if necessary
C:\>cp values.local.yaml config.yaml
## Install or upgrade MinIO using Helm, ensuring proper configuration
C:\>helm upgrade --cleanup-on-fail --install minio . --namespace d4n-storage --values config.yaml
```

🛎️ **If deploying on a local Docker Desktop Kubernetes cluster**
```powershell
## Apply the local load balancer configuration to expose MinIO at http://localhost:9001
## The internal service endpoint for JupyterHub and Apache NiFi remains:
## http://minio.d4n-storage.svc.cluster.local:9000
C:\>kubectl apply -f local-loadbalancer.yaml
```

🛎️ **If deploying on a remote server**
```powershell
## Apply the NodePort proxy configuration to expose MinIO at http://{master_ip_address}:309
## The internal service endpoint for JupyterHub and Apache NiFi remains:
## http://minio.d4n-storage.svc.cluster.local:9000
C:\>kubectl apply -f proxy.nodeport.yaml --namespace d4n-storage
```

## 2. Deploy JupyterHub (Analytics)

```powershell
## Navigate to the JupyterHub deployment directory
C:\>cd $Env:D4N_WORKSPACE_CODE\d4n-jupyterhub
## Add the official JupyterHub Helm repository and update Helm repositories
C:\>helm repo add jupyterhub https://hub.jupyter.org/helm-chart/
C:\>helm repo update
## Create a dedicated namespace for analytics components
C:\>kubectl create namespace d4n-analytics
## Copy the local configuration file and edit it if necessary
C:\>cp values.local.yaml config.yaml
## Install or upgrade JupyterHub using Helm with the specified configuration
C:\>helm upgrade --cleanup-on-fail --install jupyter jupyterhub/jupyterhub --namespace d4n-analytics --version=3.0.3 --values config.yaml
```

🛎️ **If deploying on a local Docker Desktop Kubernetes cluster**
```powershell
## Apply the local load balancer configuration to expose JupyterHub at http://localhost:8080
C:\>kubectl apply -f local-loadbalancer.yaml
```

🛎️ **If deploying on a remote server**
```powershell
## Apply the NodePort proxy configuration to expose JupyterHub at http://{master_ip_address}:30808
C:\>kubectl apply -f proxy.nodeport.yaml --namespace d4n-analytics
```

## 3. Deploy Apache NiFi (Ingestion)

```powershell
## Navigate to the Apache NiFi deployment directory
C:\>cd $Env:D4N_WORKSPACE_CODE\d4n-apache-nifi
## Add the official Apache NiFi Helm repository and update Helm repositories
C:\>helm repo add cetic https://cetic.github.io/helm-charts
C:\>helm repo update
## Copy the local configuration file and edit it if necessary
C:\>cp values.local.yaml config.yaml
## Create a dedicated namespace for ingestion components
C:\>kubectl create namespace d4n-ingestion
## Install or upgrade Apache NiFi using Helm with the specified configuration
C:\>helm upgrade --cleanup-on-fail --install nifi cetic/nifi --namespace d4n-ingestion --version=1.2.1 --values config.yaml
```

🛎️ **If deploying on a local Docker Desktop Kubernetes cluster**
```powershell
## Apply the local load balancer configuration to expose Apache NiFi at https://localhost:8443
C:\>kubectl apply -f local-loadbalancer.yaml
```

🛎️ **If deploying on a remote server**
```powershell
## Apply the NodePort proxy configuration to expose Apache NiFi at https://{master_ip_address}:30443
C:\>kubectl apply -f proxy.nodeport.yaml --namespace d4n-ingestion
```