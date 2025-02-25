# Prepare the server (all nodes)

```bash
## update the packages
$sudo apt-get update -y
## Disable swap
$sudo swapoff -a
$sudo sed -i '/swap/d' /etc/fstab


## Configure kernel parameters
$sudo cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

$sudo modprobe overlay
$sudo modprobe br_netfilter

$sudo cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

$sudo sysctl --system
```