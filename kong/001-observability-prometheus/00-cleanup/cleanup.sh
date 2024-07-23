#!/bin/bash

TOKEN=$1
REGION=${2:-eu}
RESPONSE=$(bash ../03-install-kong/get-control-plane.sh $TOKEN $REGION)
CONTROL_PLANE_ID=$(echo $RESPONSE | jq -r '.control_plane_id')

KIND_EXPERIMENTAL_PROVIDER=podman kind delete cluster
rm ../03-install-kong/certs/*
rm ../03-install-kong/03-values.yaml
rm ../05-scrape-metrics/05-values.yaml
rm ../06-grafana-visualization/06-values.yaml
rm ../07-alerting/07-values.yaml

if [ -n "$CONTROL_PLANE_ID" ]; then
  http DELETE https://${REGION}.api.konghq.com/v2/control-planes/${CONTROL_PLANE_ID} "Authorization: Bearer ${TOKEN}"
fi
