# Install Kubenetes cluster

## Install the required packages
```bash
## install required packages
$sudo apt-get install -y socat conntrack 
## download KubeKey  
$sudo curl -sfL https://get-kk.kubesphere.io | sh -
$sudo mv kk /usr/local/bin && sudo rm kubekey*
```

## Create and edit the cluster configuration
```bash
## create kubernetes cluster config file
$sudo kk create config -f kubernetes-config.yaml
## edit and add server configurations
#  hosts:
#  - {name: master, address: 172.31.5.246, internalAddress: 172.31.5.246, user: root, privateKeyPath: "~/.ssh/id_rsa"}
#  ....
#  kubernetes:
#   # more supported version: https://github.com/kubesphere/kubekey/blob/master/docs/kubernetes-versions.md
#    version: v1.25.3
#    containerManager: docker
#  ....
#  network:
#    plugin: flannel
$sudo nano kubernetes-config.yaml
```

## Deploy the cluster based on the configuration file 

```bash
## install the cluster
$sudo kk create cluster -f kubernetes-config.yaml
```

## Deploy a metrics component

```bash
## install the component
$sudo kubectl apply -f https://github.com/aristide/d4n-sl-datapipeline/blob/main/kubernetes-cluster/configs/metrcics-server-components.yaml
## Check the deployment process
$sudo kubectl get deployment metrics-server -n kube-system
## make sure that the metrics server is running
$sudo kubectl get pods --namespace kube-system
## check the resources usage
$sudo kubectl top nodes
```
