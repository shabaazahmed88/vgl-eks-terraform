locals {
  azs = [
    "${var.region}a",
    "${var.region}b",
    "${var.region}c",
  ]
}

module "vpc" {
  source = "../../modules/vpc"

  name = var.name
  cidr = "10.20.0.0/16"

  azs             = local.azs
  private_subnets = ["10.20.1.0/24", "10.20.2.0/24", "10.20.3.0/24"]
  public_subnets  = ["10.20.101.0/24", "10.20.102.0/24", "10.20.103.0/24"]

  enable_nat_gw = true
  single_nat_gw = true
}

module "eks" {
  source = "../../modules/eks-cluster"

  cluster_name    = var.name
  vpc_id          = module.vpc.vpc_id
  private_subnets = module.vpc.private_subnets
  public_subnets  = module.vpc.public_subnets

  system_instance_types = ["t3.medium"]
  work_instance_types   = ["m7a.large", "c7a.large", "m6a.large"]
  enable_spot_work      = true

  desired_size_work   = 1
  min_size_work       = 0
  max_size_work       = 4
}

module "addons" {
  source = "../../modules/eks-addons"

  cluster_name = module.eks.cluster_name
  region       = var.region
}

output "cluster_name"     { value = module.eks.cluster_name }
output "cluster_endpoint"  { value = module.eks.cluster_endpoint }
output "vpc_id"            { value = module.vpc.vpc_id }
