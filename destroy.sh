#!/bin/bash

set -e

echo "🔁 Step 1: Uninstall Helm releases (if any)..."
helm uninstall jenkins -n jenkins || echo "ℹ️ Jenkins not found"
helm uninstall argo-cd -n argocd || echo "ℹ️ Argo CD not found"
helm uninstall kube-prometheus-stack -n monitoring || echo "ℹ️ Monitoring not found"

echo "⏳ Waiting 30 seconds to allow LoadBalancers to detach..."
sleep 30

echo "🧹 Step 2: Destroy application modules..."
terraform destroy -target=module.argo_cd -auto-approve
terraform destroy -target=module.jenkins -auto-approve
terraform destroy -target=module.monitoring -auto-approve

echo "🛠 Step 3: Destroy EKS and database modules..."
terraform destroy -target=module.eks -auto-approve
terraform destroy -target=module.rds -auto-approve

echo "🌐 Step 4: Destroy VPC..."
terraform destroy -target=module.vpc -auto-approve

echo "✅ All resources destroyed safely!"
