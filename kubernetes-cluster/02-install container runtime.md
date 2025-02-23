# Container Runtime (all nodes)

## choice A: cri-docler

```bash

## docker 
$sudo apt install -y curl gnupg2 software-properties-common
$sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
$sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
$sudo apt update -y

$sudo apt install -y docker-ce docker-ce-cli containerd.io
$sudo systemctl enable docker
$sudo systemctl start docker


## install cri
$sudo VERSION=0.3.4
$sudo wget https://github.com/Mirantis/cri-dockerd/releases/download/v${VERSION}/cri-dockerd-${VERSION}.amd64.tgz
$sudo tar xvf cri-dockerd-${VERSION}.amd64.tgz
$sudo mv cri-dockerd/cri-dockerd /usr/local/bin/
$sudo cri-dockerd --version
$sudo wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.service
$sudo wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.socket
$sudo mv cri-docker.socket cri-docker.service /etc/systemd/system/
$sudo sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service
```

## choice 2: Containerd 
```bash
## Uninstall Conflicting Packages
$sudo for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove -y $pkg; done

## Install Required Dependencies
$sudo apt update
$sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

## Add Docker’s Official GPG Key
$sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

## Docker Repository for Containerd 
$sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

## Install Containerd
$sudo apt update
$sudo apt install -y containerd.io

## Configure containerd
$sudo mkdir -p /etc/containerd
$sudo containerd config default | sudo tee /etc/containerd/config.toml > /dev/null

## Start 
$sudo systemctl start containerd
$sudo systemctl enable containerd
```
