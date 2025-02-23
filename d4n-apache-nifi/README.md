# D4N-Apache-NiFi

[Credit to CETIC](https://github.com/cetic/helm-nifi/tree/master)

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

## Local server environment

Requirment for you to install the platform on your local computer 
 - [Docker Desktop](https://docs.docker.com/desktop/)
 - [Docker Desktop Kubernetes cluster](https://docs.docker.com/desktop/kubernetes/)

````bash
# load apache nifi application from helm repository
$helm repo add cetic https://cetic.github.io/helm-charts
$helm repo update
# copy from .local and edit the config file
$cp values.local.yaml config.yaml
# create the namespace 
$kubectl create namespace d4n-ingestion
# install or update apache nifi
$helm upgrade --cleanup-on-fail --install nifi cetic/nifi  --namespace d4n-ingestion --version=1.2.1 --values config.yaml
# make it avaible at port 30443
$kubectl apply -f proxy.nodeport.yaml --namespace d4n-ingestion
````

- Open Apache Nifi: https://localhost:30443

# Uninstallation

```bash
$kubectl delete namespace d4n-ingestion
```
