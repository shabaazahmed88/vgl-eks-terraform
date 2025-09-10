# Minimal EKS (No Helm/Kubernetes providers)

**Simple, working** EKS setup using only the **AWS provider**.

## What it does
- Creates VPC with **2 public subnets** (no NAT required)
- Creates IAM roles/policies for EKS control plane and managed node group
- Creates EKS cluster (v1.30) and one node group (t3.medium by default)

## How to use
```bash
terraform init -upgrade
terraform apply -auto-approve

# Configure kubectl
aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)

kubectl get nodes -o wide
```

### Variables
- `region` (default eu-central-1)
- `cluster_name` (default minimal-eks)
- `instance_types` (default ["t3.medium"]) — change if your AZs lack t3.medium capacity
- `desired_size`, `min_size`, `max_size`

### Notes
- Public subnets + public endpoint keep it **very simple** for interviews/PoC.
- For production, move nodes to **private subnets**, enable private endpoint, and add NAT.
