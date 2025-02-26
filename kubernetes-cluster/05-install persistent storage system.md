# Install Persistente storage 

## install required packages for longhorn on each node
```bash
## install required packages
$sudo apt update
$sudo apt install -y open-iscsi nfs-common
$sudo systemctl enable iscsid
$sudo systemctl start iscsid
## Load the iSCSI kernel module
$sudo modprobe iscsi_tcp
$echo "iscsi_tcp" | sudo tee /etc/modules-load.d/iscsi_tcp.conf
```

## install longhorn from the master
```bash 
## add longhorn repo
$sudo helm repo add longhorn https://charts.longhorn.io
$sudo helm repo update
## install longhorn
$sudo kubectl create namespace longhorn-system
$sudo helm install longhorn longhorn/longhorn --namespace longhorn-system
## check the installation
$sudo kubectl get pods -n longhorn-system
## access longhorn ui from http://<server_ip_address>:30080
$sudo kubectl apply -f https://github.com/aristide/d4n-sl-datapipeline/blob/main/kubernetes-cluster/configs/longhorn-proxy.nodeport.yaml
```

## Verify Longhorn 
```bash
## make sure that longhorn pod manager is running on each node
$sudo kubectl get pods -n longhorn-system -o wide | grep {node_name}
## verify node Integration
$sudo kubectl get nodes.longhorn.io -n longhorn-system
```
