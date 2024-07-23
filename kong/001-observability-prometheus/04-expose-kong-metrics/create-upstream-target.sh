#!/bin/sh

TOKEN=$1
REGION=${2:-eu}

RESPONSE=$(bash ../03-install-kong/get-control-plane.sh $TOKEN $REGION)
CONTROL_PLANE_ID=$(echo $RESPONSE | jq -r '.control_plane_id')
UPSTREAM_ID=$(http https://${REGION}.api.konghq.com/v2/control-planes/${CONTROL_PLANE_ID}/core-entities/upstreams?tags=tutorial "Authorization: Bearer ${TOKEN}" | jq '.data[] | .id' | jq -r)

#create target
echo '{
        "upstream": {
          "id": "'${UPSTREAM_ID}'"
        },
        "target": "httpbin.org:443",
        "weight": 100,
        "tags": [
          "tutorial"
        ]
      }' | http https://${REGION}.api.konghq.com/v2/control-planes/${CONTROL_PLANE_ID}/core-entities/upstreams/${UPSTREAM_ID}/targets "Authorization: Bearer ${TOKEN}"
