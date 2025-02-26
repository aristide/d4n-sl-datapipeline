# d4n-statsl-datapipeline 

## Prerequisites

- [Kubernetes cluster](https://kubernetes.io/docs/concepts/overview/components/): >= 1.24.1
- [Helm](https://helm.sh/docs/intro/install/): >= 3.8.0
- [Persistent Volume](https://kubernetes.io/docs/concepts/storage/persistent-volumes/) provisioner
- [kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/): 1.28.1

For EKS clusters follow the links:

- [aws cli](https://docs.aws.amazon.com/fr_fr/cli/latest/userguide/getting-started-install.html)
- [Let kubectl manage your EKS cluster](https://docs.aws.amazon.com/eks/latest/userguide/create-kubeconfig.html)

For AKS cluster follow the links:

- [az cli](https://learn.microsoft.com/en-us/cli/azure/install-azure-cli)
- [Let kubectl manage your AKS cluster](https://learn.microsoft.com/en-us/azure/aks/tutorial-kubernetes-deploy-cluster?tabs=azure-cli#connect-to-cluster-using-kubectl)

## Minio 

```bash
# move to minio folder
$cd d4n-minio
# create the namespace
$kubectl create namespace d4n-storage
# copy and edit the local config file
$cp values.local.yaml config.yaml
# install or upgrade minio
$helm upgrade --cleanup-on-fail --install minio  .  --namespace d4n-storage --values config.yaml
```

🛎️ If your are deploying on localhost docker-desktop k8s cluster
```bash
# make it avaible at http://localhost:9001 on localhost docker-desktop k8s cluster
# for JupyterHub and Apache Nifi endpoint url, use: http://minio.d4n-storage.svc.cluster.local:9000
$kubectl apply -f ../kubernetes-cluster/configs/local-loadbalancer.yaml
```

🛎️ If your are deploying on the server
```bash
# make it avaible at http://{master_ip_address}:309 on the server
# for JupyterHub and Apache Nifi endpoint url, use: http://minio.d4n-storage.svc.cluster.local:9000
$kubectl apply -f proxy.nodeport.yaml --namespace d4n-storage
```

## Jupyterlab


```bash
# move to jupyterhub folder
$cd d4n-jupyterhub
# load helm repository
$helm repo add jupyterhub https://hub.jupyter.org/helm-chart/
$helm repo update
# create the name space
$kubectl create namespace d4n-analytics
# copy and edit the local config file 
$cp values.local.yaml config.yaml
# install or upgrade the environement
$helm upgrade --cleanup-on-fail --install jupyter jupyterhub/jupyterhub  --namespace d4n-analytics --version=3.0.3 --values config.yaml
```

🛎️ If your are deploying on localhost docker-desktop k8s cluster
```bash
# make it avaible at http://localhost:8080 on localhost docker-desktop k8s cluster
$kubectl apply -f ../kubernetes-cluster/configs/local-loadbalancer.yaml
```

🛎️ If your are deploying on the server 
```bash
# make it avaible at http://{master_ip_address}:30808 on the server
$kubectl apply -f proxy.nodeport.yaml --namespace d4n-analytics
```

## Apache Nifi

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

