#!/bin/bash

SLACK_WEBHOOK=$1

cp ../06-grafana-visualization/06-values.yaml ./07-values.yaml
cat ./values.yaml >> ./07-values.yaml
sed -i '' "s~\$slack_webhook~${SLACK_WEBHOOK}~g" ./07-values.yaml

helm upgrade -i prometheus prometheus-community/kube-prometheus-stack -f ./07-values.yaml -n monitoring

cat ./07-values.yaml
