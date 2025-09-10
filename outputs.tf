output "cluster_name" {
  value = aws_eks_cluster.this.name
}
output "cluster_endpoint" {
  value = aws_eks_cluster.this.endpoint
}
output "subnet_ids" {
  value = [aws_subnet.public[0].id, aws_subnet.public[1].id]
}
output "region" {
  value = var.region
}
