# Install Kubenetes cluster

```bash
## install required packages
$sudo apt-get install -y socat conntrack 
## download KubeKey  
$sudo curl -sfL https://get-kk.kubesphere.io | sh -
$sudo mv kk /usr/local/bin && sudo rm kubekey-*
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
## install the cluster
$sudo kk create cluster -f kubernetes-config.yaml
## edvanced :edit the congi/!\ to add a new worker to the cluster: edit kubernetes-config.yaml  and run 
$sudo kk add nodes -f kubernetes-config.yaml
## download metrics server kubernetes component
$sudo wget https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
## edit and add "--kubelet-insecure-tls" argument to the args section of the Metrics Server container
$sudo nano component.yaml
## install the 
$sudo kubectl apply -f components.yaml
$sudo kubectl get deployment metrics-server -n kube-system
## check the installation
$sudo kubectl top nodes
```
