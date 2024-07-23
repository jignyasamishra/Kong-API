#!/bin/bash

TOKEN=$1
REGION=${2:-eu}

response=$(bash ./get-control-plane.sh $TOKEN $REGION)
control_plane_endpoint=$(echo $response | jq -r '.control_plane_endpoint')
telemetry_endpoint=$(echo $response | jq -r '.telemetry_endpoint')
control_plane_id=$(echo $response | jq -r '.control_plane_id')

sed "s~\$control_plane_endpoint~${control_plane_endpoint#https://}~g ; s~\$telemetry_endpoint~${telemetry_endpoint#https://}~g" ./values.yaml > ./03-values.yaml

cat ./03-values.yaml
