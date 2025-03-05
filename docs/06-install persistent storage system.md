# 6. Installation of Persistent Storage

This section outlines the necessary steps to install and configure persistent storage using Longhorn. These steps ensure that each node is equipped with the required dependencies, and that Longhorn is correctly deployed and verified within the Kubernetes cluster.

## 6.1. Installation of Required Packages for Longhorn

```bash
## Update package lists to ensure availability of the latest versions
$sudo apt update
## Install Open-iSCSI and NFS support, which are essential for Longhorn storage operations
$sudo apt install -y open-iscsi nfs-common
## Enable and start the iSCSI daemon to ensure automatic startup on boot
$sudo systemctl enable iscsid
$sudo systemctl start iscsid
## Load the iSCSI kernel module to support iSCSI storage connections
$sudo modprobe iscsi_tcp
## Persistently enable the iSCSI module to ensure it loads at boot time
$echo "iscsi_tcp" | sudo tee /etc/modules-load.d/iscsi_tcp.conf
```

## 6.2. Installation of Longhorn from the Master Node

```bash
## Add the official Longhorn Helm repository to the Helm package manager
$sudo helm repo add longhorn https://charts.longhorn.io
## Update the Helm repository to fetch the latest available versions
$sudo helm repo update
## Create a dedicated namespace for Longhorn within the Kubernetes cluster
$sudo kubectl create namespace longhorn-system
## Deploy Longhorn using Helm within the dedicated namespace
$sudo helm install longhorn longhorn/longhorn --namespace longhorn-system
## Verify the installation by listing all pods in the Longhorn namespace
$sudo kubectl get pods -n longhorn-system
## Apply a Kubernetes configuration to expose the Longhorn UI via a NodePort service
$sudo kubectl apply -f $D4N_REPOSITORY/blob/main/docs/configs/longhorn-proxy.nodeport.yaml
## The Longhorn UI can now be accessed via HTTP at: http://<server_ip_address>:30080
```

## 6.3. Verification of Longhorn Deployment

```bash
## Ensure that the Longhorn pod manager is running on each node
$sudo kubectl get pods -n longhorn-system -o wide | grep {node_name}
## Verify the integration of nodes with Longhorn storage
$sudo kubectl get nodes.longhorn.io -n longhorn-system
```
