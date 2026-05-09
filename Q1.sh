#!/bin/bash
set -e

# Deploy Metrics Server
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

# Patch deployment to allow insecure TLS
kubectl -n kube-system patch deployment metrics-server \
  --type='json' \
  -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'


# Wait for rollout to finish
kubectl rollout status deployment metrics-server -n kube-system
