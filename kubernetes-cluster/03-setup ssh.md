# Setup Ssh access

## Generate ssh key from the master

```bash
## make sure ssh service is installed
$sudo apt-get install -y openssh-server
## install dependences and install rsa key [master] 
$sudo ssh-keygen -t rsa -b 4096 -N "" -f ~/.ssh/id_rsa
## copy ssh key on the master [master]
$sudo cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
## restart sshd service [master]
$sudo systemctl restart ssh
```

## Copy ssh key on the node

### Alternative n°1

```bash
## Enable ssh root login on the node [node]
$sudo sed -i '/^PermitRootLogin yes$/d' /etc/ssh/sshd_config
## restart sshd service [node]
$sudo systemctl restart ssh
## copy SSH key to nodes [master]
$ssh-copy-id -i ~/.ssh/id_rsa.pub root@<node_ip_address>
## Disable ssh root login on the node [node]
$sudo sed -i '/^PermitRootLogin yes$/d' /etc/ssh/sshd_config
## restart sshd service [node]
$sudo systemctl restart ssh
```

### Alternative n°2

```bash
## send the rsa_key on each nodes [master]
$sudo scp ~/.ssh/id_rsa.pub  <user>@<node_ip_address>:/home/<user>
## connect to the node [master]
$sudo ssh user@<node_ip_address>
## Copy the SSH key to node root authorized_keys on each [node]
$sudo cat id_rsa.pub >> ~/.ssh/authorized_keys
## restart sshd service [node]
$sudo systemctl restart ssh
```
