#!/bin/bash

set -e  # Exit on any error

echo "Uninstalling ONOS umbrella chart..."
helm -n micro-onos uninstall onos-umbrella

echo "Uninstalling ONOS Operator..."
helm -n kube-system uninstall onos-operator

echo "Uninstalling Atomix Controller..."
helm -n kube-system uninstall atomix

echo "Removing Helm repositories..."
helm repo remove cord
helm repo remove atomix
helm repo remove onosproject

echo "Deleting micro-onos namespace..."
kubectl delete namespace micro-onos || echo "Namespace already deleted"

echo "Cleanup completed successfully!"

