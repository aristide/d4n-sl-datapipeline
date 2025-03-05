# Installation of Kubernetes Cluster

This section provides a structured approach to setting up a Kubernetes cluster, including installing necessary dependencies, configuring the cluster, deploying it, and setting up a metrics server for monitoring resource utilization.

## Installation of Required Packages

```bash
## Install essential dependencies for Kubernetes cluster management
$sudo apt-get install -y socat conntrack
## Download KubeKey, a lightweight tool for Kubernetes installation and cluster management
$sudo curl -sfL https://get-kk.kubesphere.io | sh -
## Move the KubeKey binary to a system-wide directory for easy execution and remove temporary installation files
$sudo mv kk /usr/local/bin && sudo rm kubekey*
```

## Creating and Editing the Cluster Configuration

```bash
## Generate a configuration file for the Kubernetes cluster
$sudo kk create config -f kubernetes-config.yaml
## Open the configuration file for editing and specify cluster details
# Sample configuration:
#  hosts:
#  - {name: {node_name}, address: {worker_ip_address}, internalAddress: {worker_ip_address}, user: root, privateKeyPath: "~/.ssh/id_rsa"}
#  ...
#  kubernetes:
#   # List of supported versions can be found at:
#   # https://github.com/kubesphere/kubekey/blob/master/docs/kubernetes-versions.md
#    version: v1.25.3
#    containerManager: docker
#  ...
#  network:
#    plugin: flannel
$sudo nano kubernetes-config.yaml
```

## Deploying the Kubernetes Cluster

```bash
## Deploy the cluster using the specified configuration file
$sudo kk create cluster -f kubernetes-config.yaml
```

## Deploying the Metrics Component

```bash
## Deploy the Metrics Server to monitor cluster resource usage
$sudo kubectl apply -f $D4N_REPOSITORY/blob/main/docs/configs/metrcics-server-components.yaml
## Verify that the Metrics Server deployment is active
$sudo kubectl get deployment metrics-server -n kube-system
## Ensure that the Metrics Server pod is running
$sudo kubectl get pods --namespace kube-system
## Display node-level resource usage statistics
$sudo kubectl top nodes
```

