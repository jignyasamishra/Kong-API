#import Kong dashboard
cp ../02-install-prometheus/values.yaml ./06-values.yaml
cat ./values.yaml >> ./06-values.yaml

helm upgrade -i prometheus prometheus-community/kube-prometheus-stack -f ./06-values.yaml -n monitoring

cat ./06-values.yaml
