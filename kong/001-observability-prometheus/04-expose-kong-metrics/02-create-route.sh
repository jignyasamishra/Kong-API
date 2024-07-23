#!/bin/sh

TOKEN=$1
REGION=${2:-eu}

RESPONSE=$(bash ../03-install-kong/get-control-plane.sh $TOKEN $REGION)
CONTROL_PLANE_ID=$(echo $RESPONSE | jq -r '.control_plane_id')
SERVICE_ID=$(bash ./get-service.sh $TOKEN $REGION | jq -r '.service_id')

echo '
{
  "name": "demo-route",
  "paths": [
    "/demo"
  ],
  "service": {
    "id": "'${SERVICE_ID}'"
  }

}' | http https://${REGION}.api.konghq.com/v2/control-planes/${CONTROL_PLANE_ID}/core-entities/routes "Authorization: Bearer ${TOKEN}"
