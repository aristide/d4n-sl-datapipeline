# D4N-MinIO

```powershell
# move to minio folder
C:\>cd $Env:D4N_WORKSPACE_CODE\d4n-minio
# create the namespace
C:\>kubectl create namespace d4n-storage
# copy and edit the local config file
C:\>cp values.local.yaml config.yaml
# install or upgrade minio
C:\>helm upgrade --cleanup-on-fail --install minio  .  --namespace d4n-storage --values config.yaml
```

🛎️ If your are deploying on localhost docker-desktop k8s cluster
```powershell
# make it avaible at http://localhost:9001 on localhost docker-desktop k8s cluster
# for JupyterHub and Apache Nifi endpoint url, use: http://minio.d4n-storage.svc.cluster.local:9000
C:\>kubectl apply -f local-loadbalancer.yaml
```

🛎️ If your are deploying on the server
```powershell
# make it avaible at http://{master_ip_address}:309 on the server
# for JupyterHub and Apache Nifi endpoint url, use: http://minio.d4n-storage.svc.cluster.local:9000
C:\>kubectl apply -f proxy.nodeport.yaml --namespace d4n-storage
```
