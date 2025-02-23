# D4N-JupyterHub

[Credit to Zerok8chart](https://github.com/jupyterhub/zero-to-jupyterhub-k8s/tree/main)

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

```bash
# load helm repository
$helm repo add jupyterhub https://hub.jupyter.org/helm-chart/
$helm repo update
# create the name space
$kubectl create namespace d4n-analytics
# copy and edit the local config file 
$cp values.local.yaml config.yaml
# install or upgrade the environement
$helm upgrade --cleanup-on-fail --install jupyter jupyterhub/jupyterhub  --namespace d4n-analytics --version=3.0.3 --values config.yaml
# make it avaible at port 30808
$kubectl apply -f proxy.nodeport.yaml --namespace d4n-analytics
```

- Open Jupyterhub: http://{master_ip_address}:30808

# Uninstallation

Uninstall and remove all the resources 

```bash
$kubectl delete namespace d4n-analytics
```
# Configurations

The variables to consider when configuring the deployment.

Requirements:
   - create a technical user with the rigth to read DN from AD.
   - LDAP config variables are provided by [ldap authenticator module](https://github.com/jupyterhub/ldapauthenticator)
   - size your installation: nbr of user etc.



