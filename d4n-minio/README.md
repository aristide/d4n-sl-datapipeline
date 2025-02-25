# D4N-MinIO

[Credit goes to Minio community](https://github.com/minio/minio)

# Prerequisites

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

# Installation

## Local server  environment 

Requirement for you to install the platform on your local computer 
 - [Docker Desktop](https://docs.docker.com/desktop/)
 - [Docker Desktop Kubernetes cluster](https://docs.docker.com/desktop/kubernetes/)

```bash
# load helm repository
$helm repo add minio https://charts.min.io/
$helm repo update
# create the namespace
$kubectl create namespace d4n-storage
# copy and edit the local config file
$cp values.local.yaml config.yaml
# install or upgrade minio
$helm upgrade --cleanup-on-fail --install minio .  --namespace d4n-storage --values config.yaml
# make it avaible at port 30901 & 30900
$kubectl apply -f proxy.nodeport.yaml --namespace d4n-storage
```

- Open Minio console: http://{master_ip_address}:30901
- Access Minio API: http://{master_ip_address}:30900

# Uninstallation

Uninstall and remove all the resources

```bash
$kubectl delete namespace d4n-storage
```

