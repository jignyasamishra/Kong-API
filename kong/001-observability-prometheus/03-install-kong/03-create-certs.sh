#!/usr/bin/env bash

TOKEN=$1
REGION=${2:-eu}

RESPONSE=$(bash ./get-control-plane.sh $TOKEN $REGION)
CONTROL_PLANE_ID=$(echo $RESPONSE | jq -r '.control_plane_id')

mkdir ./certs

rm -f ./certs/tls.crt
rm -f ./certs/tls.key

openssl req -new -x509 -nodes -newkey ec:<(openssl ecparam -name secp384r1) -keyout certs/tls.key -out certs/tls.crt -days 1095 -subj "/C=GB/ST=London/L=London/O=Global Security/OU=IT Department/CN=example.com"

# Get the certificate as a single line for the API call
export CERT=$(awk 'NF {sub(/\r/, ""); printf "%s\\n",$0;}' certs/tls.crt)

echo '
{
  "cert": "'$CERT'"
}' | http POST https://${REGION}.api.konghq.com/v2/control-planes/${CONTROL_PLANE_ID}/dp-client-certificates "Authorization: Bearer ${TOKEN}"
