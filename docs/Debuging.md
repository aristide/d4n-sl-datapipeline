# Debugging

## Network 

Install plugin manager  as Admin

```powershell
C:\>$krewUrl = "https://github.com/kubernetes-sigs/krew/releases/download/v0.4.4/krew.exe"
C:\>Invoke-WebRequest -Uri $krewUrl -OutFile "$Env:D4N_WORKSPACE_CLI\krew.exe"
```

restart powershell as user
```powershell
C:\>$currentPath = [System.Environment]::GetEnvironmentVariable('Path', [System.EnvironmentVariableTarget]::User)
C:\>$newPath = "$currentPath;$HOME\.krew\bin"
C:\>[System.Environment]::SetEnvironmentVariable('Path', $newPath, [System.EnvironmentVariableTarget]::User)
```

restart powershell  as admin

Install network plugin
```powershell
kubectl krew index add netshoot https://github.com/nilic/kubectl-netshoot.git
kubectl krew install netshoot/netshoot
```

restart powershel as user
```powershell

```

