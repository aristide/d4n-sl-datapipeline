# Container Runtime Installation (All Nodes)

This section details the installation and configuration of the container runtime, which is a fundamental requirement for Kubernetes nodes. The following steps ensure a reliable and efficient installation of Docker and cri-dockerd.

```bash
## Install prerequisite packages for Docker
$sudo apt install -y curl gnupg2 software-properties-common
## Add the official Docker GPG key to the system for package verification
$sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
## Add the Docker repository to the system's package sources
$sudo echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
## Update package lists to include Docker's repository
$sudo apt update -y
## Install Docker and its necessary components
$sudo apt install -y docker-ce docker-ce-cli containerd.io
## Enable Docker to start at system boot
$sudo systemctl enable docker
## Start the Docker service
$sudo systemctl start docker
## Install cri-dockerd (Container Runtime Interface for Docker)
$VERSION=0.3.4
## Download the cri-dockerd archive
$sudo wget https://github.com/Mirantis/cri-dockerd/releases/download/v${VERSION}/cri-dockerd-${VERSION}.amd64.tgz
## Extract the contents of the downloaded archive
$sudo tar xvf cri-dockerd-${VERSION}.amd64.tgz
## Move the cri-dockerd binary to the appropriate system directory
$sudo mv cri-dockerd/cri-dockerd /usr/local/bin/
## Verify the installation by checking the version
$sudo cri-dockerd --version
## Download the necessary systemd service files for cri-dockerd
$sudo wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.service
$sudo wget https://raw.githubusercontent.com/Mirantis/cri-dockerd/master/packaging/systemd/cri-docker.socket
## Move the service files to the systemd directory
$sudo mv cri-docker.socket cri-docker.service /etc/systemd/system/
## Modify the service file to reference the correct binary location
$sudo sed -i -e 's,/usr/bin/cri-dockerd,/usr/local/bin/cri-dockerd,' /etc/systemd/system/cri-docker.service
## Reload systemd to recognize the new services
$sudo systemctl daemon-reload
## Enable cri-dockerd to start at system boot
$sudo systemctl enable cri-docker
## Start the cri-dockerd service
$sudo systemctl start cri-docker
## Check the status of the cri-dockerd service to ensure it is running
$sudo systemctl status cri-docker
```
