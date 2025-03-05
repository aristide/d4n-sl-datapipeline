# D4N-JupyterHub

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

# Active Directory Configurations

The variables to consider when configuring the deployment.

Requirements:
   - create a technical user with the rigth to read DN(Distinguished Name) from AD.
   - LDAP config variables are provided by [ldap authenticator module](https://github.com/jupyterhub/ldapauthenticator)
   - size your installation: nbr of user etc.
