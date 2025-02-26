# D4N-JupyterHub

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

# Active Directory Configurations

The variables to consider when configuring the deployment.

Requirements:
   - create a technical user with the rigth to read DN(Distinguished Name) from AD.
   - LDAP config variables are provided by [ldap authenticator module](https://github.com/jupyterhub/ldapauthenticator)
   - size your installation: nbr of user etc.
