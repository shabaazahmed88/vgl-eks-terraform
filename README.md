# VGL EKS Terraform (Complete)

This repo provisions a FinOps-friendly EKS cluster using Terraform.

## Structure

```
infra/
  modules/
    vpc/
    eks-cluster/
    eks-addons/
  envs/
    dev/
    prod/
.github/workflows/terraform.yml
```

## Quick Start

```bash
cd infra/envs/dev
terraform init
terraform apply

aws eks --region eu-central-1 update-kubeconfig --name vgl-dev
kubectl get nodes -o wide
```

Managed addons installed: coredns, kube-proxy, vpc-cni, **aws-ebs-csi-driver**. Helm installs **metrics-server**.
