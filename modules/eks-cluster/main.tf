terraform {
  required_version = ">= 1.6"
  required_providers {
    aws = { source = "hashicorp/aws", version = ">= 5.55.0" }
  }
}

locals {
  tags = merge({
    "managed-by" = "terraform",
    "app"        = "vgl",
  }, var.tags)
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "20.31.5"

  cluster_name    = var.cluster_name
  cluster_version = var.cluster_version
  enable_irsa     = true

  vpc_id     = var.vpc_id
  subnet_ids = var.private_subnets

  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = false

  cluster_enabled_log_types = ["api", "audit", "authenticator", "controllerManager", "scheduler"]

  eks_managed_node_groups = {
    system = {
      min_size     = var.min_size_system
      max_size     = var.max_size_system
      desired_size = var.desired_size_system
      instance_types = var.system_instance_types
      labels = { role = "system" }
      taints = [{ key = "CriticalAddonsOnly", value = "true", effect = "NO_SCHEDULE" }]
      capacity_type = "ON_DEMAND"
    }

    work = {
      min_size     = var.min_size_work
      max_size     = var.max_size_work
      desired_size = var.desired_size_work
      instance_types = var.work_instance_types
      labels = { role = "workload" }
      capacity_type = var.enable_spot_work ? "SPOT" : "ON_DEMAND"
    }
  }

  cluster_addons = {
    coredns            = { most_recent = true }
    kube-proxy         = { most_recent = true }
    vpc-cni            = { most_recent = true }
    aws-ebs-csi-driver = { most_recent = true }
  }

  tags = local.tags
}
