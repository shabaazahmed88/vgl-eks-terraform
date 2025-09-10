# VGL EKS Terraform (v3)

Fixes:
- Proper multi-line variable blocks (no inline `type ... default`).
- Child module `eks-addons` declares `required_providers` so provider mapping is recognized.
- Helm/Kubernetes providers configured at env level and passed to addons via `providers` map.

## Quick Start
```bash
cd infra/envs/dev
rm -rf .terraform .terraform.lock.hcl
terraform init -upgrade
terraform apply

aws eks --region eu-central-1 update-kubeconfig --name vgl-dev
kubectl get nodes -o wide
```
