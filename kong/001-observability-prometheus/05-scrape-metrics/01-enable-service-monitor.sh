#!/bin/bash

cp ../03-install-kong/03-values.yaml ./05-values.yaml
cat ./values.yaml >> ./05-values.yaml

helm upgrade -i konnect-dp kong/kong -n kong -f ./05-values.yaml --create-namespace

cat ./05-values.yaml
