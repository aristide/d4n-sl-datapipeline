# Debugging

## Network 

Install plugin manager 

```powershell
C:\>$krewUrl = "https://github.com/kubernetes-sigs/krew/releases/download/v0.4.4/krew.exe"
C:\>Invoke-WebRequest -Uri $krewUrl -OutFile "$Env:D4N_WORKSPACE_CLI\krew.exe"

```

Install network plugin


