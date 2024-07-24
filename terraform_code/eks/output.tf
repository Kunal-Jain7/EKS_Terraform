output "cluster_endpoint" {
  value = aws_eks_cluster.kubes-cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.kubes-cluster.certificate_authority[0].data
}

output "cluster_id" {
  value = aws_eks_cluster.kubes-cluster.id
}

output "cluster_name" {
  value = aws_eks_cluster.kubes-cluster.name
}