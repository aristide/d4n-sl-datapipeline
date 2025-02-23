## Install Persistente storage

```bash
## install required packages
$sudo apt update
$sudo apt install -y open-iscsi nfs-common
$sudo systemctl enable iscsid
$sudo systemctl start iscsid
## Load the iSCSI kernel module
$sudo modprobe iscsi_tcp
$echo "iscsi_tcp" | sudo tee /etc/modules-load.d/iscsi_tcp.conf
## download helm 
$sudo curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
## add longhorn repo
$sudo helm repo add longhorn https://charts.longhorn.io
$sudo helm repo update
## install longhorn
$sudo kubectl create namespace longhorn-system
$sudo helm install longhorn longhorn/longhorn --namespace longhorn-system
## check the installation
$sudo kubectl get pods -n longhorn-system
## access longhorn ui
$sudo kubectl -n longhorn-system port-forward service/longhorn-frontend 8080:80
```