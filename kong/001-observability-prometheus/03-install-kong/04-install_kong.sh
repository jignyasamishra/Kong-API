#!/bin/bash

#create secret for dataplane
kubectl create ns kong
kubectl create secret tls kong-cluster-cert -n kong --cert=./certs/tls.crt --key=./certs/tls.key --namespace kong
helm repo add kong https://charts.konghq.com
helm repo update

#install kong
helm upgrade -i konnect-dp kong/kong -n kong -f ./03-values.yaml
