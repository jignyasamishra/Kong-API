#!/bin/sh

TOKEN=$1
REGION=${2:-eu}

RESPONSE=$(bash ../03-install-kong/get-control-plane.sh $TOKEN $REGION)
CONTROL_PLANE_ID=$(echo $RESPONSE | jq -r '.control_plane_id')
SERVICE_ID=$(bash ./get-service.sh $TOKEN $REGION | jq -r '.service_id')

echo '
{
  "name":"prometheus",
  "config":{
    "per_consumer":true,
    "status_code_metrics": true,
    "latency_metrics": true,
    "bandwidth_metrics": true,
    "upstream_health_metrics": true
  }
}' | http https://${REGION}.api.konghq.com/v2/control-planes/${CONTROL_PLANE_ID}/core-entities/services/${SERVICE_ID}/plugins "Authorization: Bearer ${TOKEN}"

