# Prerequisites

## Informations at hands
 
 - Node: Master Ip  address referenced in the rest as  {master_ip_addres}
 - Node: worker Ip address  required the deployment documentation and referenced as {worker_ip_address}
 - uniquely name each node: master, node1, node2 called in the deployment commande line as {node_name}
 - code repository http adresse link referenced as {code_repository_link}
 - 

## Environment variables 
   D4N_CODE_REPOSITORY
   

### On the Workstation
 - set workspace path env var: D4N_WORSPACE_PATH
 ```powershell
 [System.Environment]::SetEnvironmentVariable('D4N_WORSPACE_PATH', "$HOME\MyCustomFolder", [System.EnvironmentVariableTarget]::User)
 ```
 - set master-ip_address: D4N_MASTER_IP_ADDRESS
 - set code repot env var: D4N_CODE_REPOSITORY

 - set cli path env var into PATH
 - create a working directory 
 - create the cli folder
    - download cli inside the clis
 - clone the code
 - install lens


### On the Server
 - set workspace path env var: D4N_WORSPACE_PATH
 - set code repot env var: D4N_CODE_REPOSITORY

