# D4N-MinIO

```bash
# move to minio folder
$cd d4n-minio
# create the namespace
$kubectl create namespace d4n-storage
# copy and edit the local config file
$cp values.local.yaml config.yaml
# install or upgrade minio
$helm upgrade --cleanup-on-fail --install minio  .  --namespace d4n-storage --values config.yaml
```

🛎️ If your are deploying on localhost docker-desktop k8s cluster
```bash
# make it avaible at http://localhost:9001 on localhost docker-desktop k8s cluster
# for JupyterHub and Apache Nifi endpoint url, use: http://minio.d4n-storage.svc.cluster.local:9000
$kubectl apply -f ../kubernetes-cluster/configs/local-loadbalancer.yaml
```

🛎️ If your are deploying on the server
```bash
# make it avaible at http://{master_ip_address}:309 on the server
# for JupyterHub and Apache Nifi endpoint url, use: http://minio.d4n-storage.svc.cluster.local:9000
$kubectl apply -f proxy.nodeport.yaml --namespace d4n-storage
```
