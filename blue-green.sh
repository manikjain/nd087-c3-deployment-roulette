#!/bin/bash

kubectl apply -f starter/apps/blue-green/index_green_html.yml
kubectl apply -f starter/apps/blue-green/green.yml

# Check deployment rollout status every 1 second until complete.
ATTEMPTS=0
ROLLOUT_STATUS_CMD="kubectl rollout status deployment/green -n udacity"
until $ROLLOUT_STATUS_CMD || [ $ATTEMPTS -eq 60 ]; do
$ROLLOUT_STATUS_CMD
ATTEMPTS=$((attempts + 1))
sleep 1
echo "Still deploying..."
done

green_svc_load_balancer=$(kubectl get service green-svc -n udacity --no-headers | awk '{print $4}')

curl_check_response=$(curl -s  --write-out "%{http_code}" http://${green_svc_load_balancer} | tail -1)

while [[ ${curl_check_response} != 200 ]]; do
    echo "Waiting for green service to be reachable: " ${green_svc_load_balancer}...""
    sleep 1
done