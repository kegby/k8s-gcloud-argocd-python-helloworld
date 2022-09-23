#!/bin/bash

# retrieve the access credentials for your cluster and automatically configure kubectl
gcloud container clusters get-credentials $(terraform output -raw kubernetes_cluster_name) --region $(terraform output -raw region)

# This will create a new namespace, argocd, where Argo CD services and application resources will live.
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
sleep 15
kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "LoadBalancer"}}'
