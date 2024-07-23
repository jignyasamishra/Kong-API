#!/bin/sh

TOKEN=$1
REGION=${2:-eu}

RESPONSE=$(bash ../03-install-kong/get-control-plane.sh $TOKEN $REGION)
CONTROL_PLANE_ID=$(echo $RESPONSE | jq -r '.control_plane_id')

#create upstream
bash ./create-upstream.sh $TOKEN $REGION
bash ./create-upstream-target.sh $TOKEN $REGION

#create service
echo '
{
  "name": "demo-service",
  "retries": 5,
  "protocol": "https",
  "host": "httpbin",
  "port": 443,
  "path": "/anything",
  "enabled": true,
  "tags": [
      "tutorial"
    ]
}' | http https://${REGION}.api.konghq.com/v2/control-planes/${CONTROL_PLANE_ID}/core-entities/services "Authorization: Bearer ${TOKEN}"

