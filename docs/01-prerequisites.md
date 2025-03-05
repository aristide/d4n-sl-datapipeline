# 1. Prerequisites

This section outlines the essential prerequisites for deploying the minimum Datalake infrastructure, ensuring that all necessary configurations are in place. It details the collection of critical network and system information, such as node IP addresses and repository links, to facilitate a structured deployment process. The workstation setup includes the installation of essential tools and the configuration of environment variables to maintain a standardized deployment environment. Furthermore, it provides step-by-step instructions for downloading required binaries, setting up working directories, and configuring both master and worker nodes.

## 1.1. Collect Essential Informations

The following preparatory information should be readily available:

1. **Master Node Identification:** The Internet Protocol (IP) address of the master node, hereinafter referred to as `{master_ip_address}`.
2. **Worker Node Addressing:** The IP address of each worker node, required for deployment documentation, and hereinafter referenced as `{worker_ip_address}`.
3. **Node Naming Convention:** Each node should be uniquely identified as "master," "node1," "node2," etc., referenced in the deployment command line as `{node_name}`.
4. **Code Repository Access:** The hyperlink to the official code repository, referenced as `{code_repository_link}`.

## 1.2. Workstation💻 Setup 

It is assumed that the workstation operates on the Windows operating system.

### 1.2.1. Install the Essential Tools: Git, Lens, Docker-Desktop

To facilitate deployment, install the required tools using the following procedure:

1. Open PowerShell as an administrator and execute the following commands:

```powershell
## Install Windows Chocolatey Package Manager
C:\>Set-ExecutionPolicy Bypass -Scope Process -Force; `
[System.Net.ServicePointManager]::SecurityProtocol = `
[System.Net.ServicePointManager]::SecurityProtocol -bor 3072; `
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

2. Reopen PowerShell as the current user and install the required tools:

```powershell
## Install Git
C:\>choco install git -y
## Install Lens
C:\>choco install lens -y
## Install Docker-Desktop (Optional)
C:\>choco install docker-desktop -y
```

### 1.2.2. Establishment of Working Directories

The directory structure of the workspace shall conform to the following schema:

```
$HOME\data4now\                     # Main project workspace folder
         |__cli/                      # CLI subfolder to store downloaded binaries
         |  |__helm.exe                 # Helm tool
         |  |__mc.exe                   # MinIO client tool
         |  |__kubectl.exe              # Kubernetes client tool
         |
         |__code/                     # Subfolder for code content
```

Execute the following commands to create the required directories:

```powershell
## Create main workspace directory
C:\>mkdir "$HOME\data4now"
## Create subdirectory for binary files
C:\>mkdir "$HOME\data4now\cli"
## Create subdirectory for code content
C:\>mkdir "$HOME\data4now\code"
```

### 1.2.3. Configuration of Environment Variables

Execute the following PowerShell commands to configure the necessary environment variables:

```powershell
## Define workspace path
C:\>[System.Environment]::SetEnvironmentVariable('D4N_WORKSPACE', "$HOME\data4now", [System.EnvironmentVariableTarget]::User)
## Define CLI workspace path
C:\>[System.Environment]::SetEnvironmentVariable('D4N_WORKSPACE_CLI', "$HOME\data4now\cli", [System.EnvironmentVariableTarget]::User)
## Define code workspace path
C:\>[System.Environment]::SetEnvironmentVariable('D4N_WORKSPACE_CODE', "$HOME\data4now\code", [System.EnvironmentVariableTarget]::User)
## Assign master IP address
C:\>[System.Environment]::SetEnvironmentVariable('D4N_MASTER_IP_ADDRESS', "{master_ip_address}", [System.EnvironmentVariableTarget]::User)
## Assign repository link
C:\>[System.Environment]::SetEnvironmentVariable('D4N_REPOSITORY', "{code_repository_link}", [System.EnvironmentVariableTarget]::User)
## Update system PATH with CLI directory
C:\>$currentPath = [System.Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::User)
C:\>$newPath = "$currentPath;$D4N_WORKSPACE_CLI"
C:\>[System.Environment]::SetEnvironmentVariable('Path', $newPath, [System.EnvironmentVariableTarget]::User)
```

### 1.2.4. Downloading Essential Binaries and Cloning the Repository

```powershell
## Download Helm
C:\>Invoke-WebRequest -Uri "https://get.helm.sh/helm-v3.17.1-windows-amd64.zip" -OutFile "$Env:D4N_WORKSPACE_CLI\helm.zip"
C:\>Add-Type -AssemblyName 'System.IO.Compression.FileSystem'
C:\>[System.IO.Compression.ZipFile]::ExtractToDirectory("$Env:D4N_WORKSPACE_CLI\helm.zip", $Env:D4N_WORKSPACE_CLI)
C:\>Move-Item -Path "$Env:D4N_WORKSPACE_CLI\windows-amd64\helm.exe" -Destination $Env:D4N_WORKSPACE_CLI
C:\>Remove-Item -Path "$Env:D4N_WORKSPACE_CLI\helm.zip"
C:\>Remove-Item -Path "$Env:D4N_WORKSPACE_CLI\windows-amd64" -Recurse

## Download Kubernetes client (kubectl)
C:\>$version = (Invoke-RestMethod -Uri https://dl.k8s.io/release/stable.txt).Trim()
C:\>$url = "https://dl.k8s.io/$version/bin/windows/amd64/kubectl.exe"
C:\>Invoke-WebRequest -Uri $url -OutFile "$Env:D4N_WORKSPACE_CLI\kubectl.exe"

## Download MinIO client (mc)
C:\>Invoke-WebRequest -Uri "https://dl.min.io/client/mc/release/windows-amd64/mc.exe" -OutFile "$Env:D4N_WORKSPACE_CLI\mc.exe"

## Clone the repository
C:\>git clone "$Env:D4N_REPOSITORY.git" $Env:D4N_WORKSPACE_CODE
```

## 1.3. Configuration on Master🖥 Node

```bash
## Update package lists
$sudo apt-get update -y
## Install SSH service
$sudo apt-get install -y openssh-server
## Enable root SSH login
$sudo echo "PermitRootLogin yes" | sudo tee -a /etc/ssh/sshd_config > /dev/null
## Restart SSH service
$sudo systemctl restart ssh
## Define repository environment variable
$echo 'D4N_REPOSITORY="{code_repository_link}"' | sudo tee -a /etc/environment
## Reboot the server
$sudo reboot
```

## 1.4. Configuration on Worker🖥 Node

```bash
## Update package lists
$sudo apt-get update -y
## Install SSH service
$sudo apt-get install -y openssh-server
## Enable root SSH login
$sudo echo "PermitRootLogin yes" | sudo tee -a /etc/ssh/sshd_config > /dev/null
## Restart SSH service
$sudo systemctl restart ssh
```

