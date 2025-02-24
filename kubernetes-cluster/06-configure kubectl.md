# Configure Kubectl workstation

## Newly installed kubectl 

```powershell
## Copy the New kubeconfig File Locally 
$scp user@remote-server-ip:/etc/kubernetes/admin.conf C:\Users\YourUsername\.kube\config
## 
```

Edit the kubeconfig file

![Area to change](../img/admin_kubeconfig.png)

```powershell
## Verify the Cluster Connection
$kubectl config get-contexts
$kubectl get nodes
```

## Already have existing cluster(s) configured

```bash
## kubeconfig File Locally
$scp user@remote-server-ip:/etc/kubernetes/admin.conf C:\Users\YourUsername\.kube\new-config
```

Edit the kubeconfig file

![Area to change](../img/admin_kubeconfig.png)

```powershell
## Merge the New kubeconfig with the Existing One
$$env:KUBECONFIG="C:\Users\YourUsername\.kube\config;C:\Users\YourUsername\.kube\new-config"
$kubectl config view --merge --flatten | Out-File -Encoding ascii C:\Users\YourUsername\.kube\config
## Verify the Cluster Connection
$kubectl config get-contexts
$kubectl config use-context <context-name>
$kubectl get nodes
```
