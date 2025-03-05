# 4. Secure Shell (SSH) Access Configuration

This section outlines the necessary steps to establish secure and password-less SSH access between the master node and worker nodes. This setup facilitates seamless remote management and communication between the nodes in a Kubernetes cluster.

## 4.1. Generating an SSH Key on the Master Node

```bash
## Generate an SSH key pair with RSA encryption (4096-bit) without a passphrase
$sudo ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
## Append the generated public key to the list of authorized keys
$sudo cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
## Restart the SSH service to apply changes
$sudo systemctl restart ssh
```

## 4.2. Distributing the SSH Key to Worker Nodes

```bash
## Copy the SSH public key from the master node to each worker node
$ssh-copy-id -i ~/.ssh/id_rsa.pub root@<node_ip_address>
## Restart the SSH service on the worker node to apply the changes
$ssh root@<node_ip_address> 'sudo systemctl restart ssh'
```

