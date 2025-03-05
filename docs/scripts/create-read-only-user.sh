#!/bin/bash

# Variables
NAMESPACE="kube-system"
SERVICE_ACCOUNT_NAME="readonly-user"
CLUSTER_ROLE_NAME="view"
SECRET_NAME="${SERVICE_ACCOUNT_NAME}-token"
KUBECONFIG_FILE="readonly-user-kubeconfig.yaml"

# Create Service Account
kubectl create serviceaccount "${SERVICE_ACCOUNT_NAME}" --namespace "${NAMESPACE}"

# Create ClusterRoleBinding for read-only access
kubectl create clusterrolebinding "${SERVICE_ACCOUNT_NAME}-binding" \
  --clusterrole="${CLUSTER_ROLE_NAME}" \
  --serviceaccount="${NAMESPACE}:${SERVICE_ACCOUNT_NAME}"

# Create Secret for the Service Account token
cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Secret
metadata:
  name: "${SECRET_NAME}"
  namespace: "${NAMESPACE}"
  annotations:
    kubernetes.io/service-account.name: "${SERVICE_ACCOUNT_NAME}"
type: kubernetes.io/service-account-token
EOF

# Wait for the Secret to be created
sleep 5

# Retrieve the Service Account token
USER_TOKEN=$(kubectl -n "${NAMESPACE}" get secret "${SECRET_NAME}" -o jsonpath='{.data.token}' | base64 --decode)

# Retrieve the current context
CURRENT_CONTEXT=$(kubectl config current-context)

# Retrieve the cluster name, server URL, and CA data
CLUSTER_NAME=$(kubectl config get-contexts "${CURRENT_CONTEXT}" | awk '{print $3}' | tail -n 1)
SERVER=$(kubectl config view -o jsonpath="{.clusters[?(@.name == \"${CLUSTER_NAME}\")].cluster.server}")
CA_DATA=$(kubectl config view --raw -o jsonpath="{.clusters[?(@.name == \"${CLUSTER_NAME}\")].cluster.certificate-authority-data}")

# Generate the kubeconfig file
cat <<EOF > "${KUBECONFIG_FILE}"
apiVersion: v1
kind: Config
clusters:
- name: ${CLUSTER_NAME}
  cluster:
    server: ${SERVER}
    certificate-authority-data: ${CA_DATA}
contexts:
- name: ${SERVICE_ACCOUNT_NAME}-context
  context:
    cluster: ${CLUSTER_NAME}
    user: ${SERVICE_ACCOUNT_NAME}
current-context: ${SERVICE_ACCOUNT_NAME}-context
users:
- name: ${SERVICE_ACCOUNT_NAME}
  user:
    token: ${USER_TOKEN}
EOF

echo "Kubeconfig file '${KUBECONFIG_FILE}' has been created successfully."

# test using kubectl --kubeconfig=readonly-user-kubeconfig.yaml get pods
