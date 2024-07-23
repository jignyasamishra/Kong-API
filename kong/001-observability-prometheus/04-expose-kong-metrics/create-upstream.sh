#!/bin/sh

TOKEN=$1
REGION=${2:-eu}

RESPONSE=$(bash ../03-install-kong/get-control-plane.sh $TOKEN $REGION)
CONTROL_PLANE_ID=$(echo $RESPONSE | jq -r '.control_plane_id')

#create upstream
echo '{
        "name": "httpbin",
        "tags": ["tutorial"],
        "algorithm": "round-robin",
        "healthchecks": {
          "active": {
            "concurrency": 10,
            "healthy": {
              "http_statuses": [200,302],
              "interval": 5,
              "successes": 5
            },
            "http_path": "/",
            "https_verify_certificate": true,
            "timeout": 1,
            "type": "http",
            "unhealthy": {
              "http_failures": 5,
              "http_statuses": [429,404,500,501,502,503,504,505],
              "interval": 5,
              "tcp_failures": 0,
              "timeouts": 0
            }
          },
          "passive": {
            "healthy": {
              "http_statuses": [200,201,202,203,204,205,206,207,208,226,300,301,302,303,304,305,306,307,308],
              "successes": 80
            },
            "type": "http",
            "unhealthy": {
              "http_failures": 5,
              "http_statuses": [429,500,503],
              "tcp_failures": 0,
              "timeouts": 5
            }
          },
          "threshold": 1
        }
      }' | http https://${REGION}.api.konghq.com/v2/control-planes/${CONTROL_PLANE_ID}/core-entities/upstreams "Authorization: Bearer ${TOKEN}"
