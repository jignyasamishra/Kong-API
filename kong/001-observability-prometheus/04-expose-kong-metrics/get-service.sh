#!/bin/bash

TOKEN=$1
REGION=${2:-eu}

RESPONSE=$(bash ../03-install-kong/get-control-plane.sh $TOKEN $REGION)
CONTROL_PLANE_ID=$(echo $RESPONSE | jq -r '.control_plane_id')

http https://${REGION}.api.konghq.com/v2/control-planes/${CONTROL_PLANE_ID}/core-entities/services?tags=tutorial "Authorization: Bearer ${TOKEN}" | jq '.data | .[] | {service_id: .id}'
