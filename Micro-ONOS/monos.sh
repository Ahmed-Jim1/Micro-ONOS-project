#!/bin/bash

set -e  # Exit on any error

echo "Adding Helm repositories..."
helm repo add cord https://charts.opencord.org
helm repo add atomix https://charts.atomix.io
helm repo add onosproject https://charts.onosproject.org

echo "Updating Helm repositories..."
helm repo update

echo "Searching ONOS charts..."
helm search repo onos

echo "Creating micro-onos namespace..."
kubectl create namespace micro-onos || echo "Namespace already exists"

echo "Deploying Atomix Controller..."
helm install -n kube-system atomix atomix/atomix

echo "Deploying ONOS Operator..."
helm install -n kube-system onos-operator onosproject/onos-operator

echo "Deploying ONOS umbrella chart..."
helm -n micro-onos install onos-umbrella onosproject/onos-umbrella

echo "Deployment completed successfully!"

