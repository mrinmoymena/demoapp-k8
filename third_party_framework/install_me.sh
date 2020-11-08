#!/bin/bash
# This script is used to provision aws resources using terraform.

set -xv

sudo /home/ec2-user/istio-install/istio-1.4.3/bin/istioctl manifest apply --set profile=demo

sudo /usr/bin/kubectl apply -f src/metrics-server-0.3.6/deploy/1.8+/

sudo /usr/bin/kubectl apply -f src/grafana.yaml
sudo /usr/bin/kubectl apply -f src/kaili.yaml
sudo /usr/bin/kubectl apply -f src/prometheus.yaml
sudo /usr/bin/kubectl apply -f src/tracing.yaml
