# VGL EKS Terraform (v2)

Production-ready, FinOps-friendly EKS with Terraform.

## Quick Start
```bash
cd infra/envs/dev
terraform init -upgrade
terraform apply

aws eks --region eu-central-1 update-kubeconfig --name vgl-dev
kubectl get nodes -o wide
```

## Troubleshooting
- **Provider mismatch** (AWS/Helm): clear plugins and re-init
```bash
rm -rf .terraform .terraform.lock.hcl
terraform init -upgrade
terraform -version  # should be >= 1.6
```
