#!/bin/bash

TOKEN=$1
REGION=${2:-eu}

echo '{
  "name": "Demo Control Plane",
  "description": "A demo control plane for this tutorial.",
  "cluster_type": "CLUSTER_TYPE_CONTROL_PLANE",
  "cloud_gateway": false,
  "auth_type": "pinned_client_certs",
  "proxy_urls": [],
  "labels": {
    "env": "tutorial"
  }
}' | http POST https://${REGION}.api.konghq.com/v2/control-planes "Authorization: Bearer ${TOKEN}"
