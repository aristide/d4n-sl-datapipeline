# Server Preparation (All Nodes)

This section outlines the necessary steps to prepare all nodes in the infrastructure for deployment. The commands below ensure system updates, disable swap memory, and configure kernel parameters essential for Kubernetes operations.

```bash
## Update package lists to ensure the latest versions are available
$sudo apt-get update -y
## Disable swap to ensure Kubernetes functions properly
$sudo swapoff -a
$sudo sed -i '/swap/d' /etc/fstab
## Load required kernel modules for Kubernetes networking
$sudo cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF
## Activate the required modules immediately
$sudo modprobe overlay
$sudo modprobe br_netfilter
## Configure system networking parameters for Kubernetes
$sudo cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1  # Allow bridge traffic to be processed by iptables
net.bridge.bridge-nf-call-ip6tables = 1  # Ensure IPv6 bridge traffic is also processed
net.ipv4.ip_forward                 = 1  # Enable IP forwarding for routing
EOF
## Apply the new system configurations
$sudo sysctl --system
```

