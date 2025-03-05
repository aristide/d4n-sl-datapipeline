# Clean-Up Procedures

This section provides guidance on securing the server environment by disabling root SSH login on all nodes, including both master and worker nodes. Restricting root access enhances security and mitigates unauthorized access risks.

## Disabling Root SSH Login on Nodes (Master and Workers)

```bash
## Remove the line that explicitly enables root login from the SSH configuration file
$sudo sed -i '/^PermitRootLogin yes$/d' /etc/ssh/sshd_config
## Restart the SSH service to apply the changes
$sudo systemctl restart ssh
```

