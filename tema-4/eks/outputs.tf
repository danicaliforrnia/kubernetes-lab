output "cluster_endpoint" {
  description = "Los endpoints para el plano de control de EKS"
  value       = module.eks.cluster_endpoint
}

output "cluster_security_group_id" {
  description = "Ids del grupo de seguridad asociados al plano de control de clúster"
  value       = module.eks.cluster_security_group_id
}

output "region" {
  description = "La región de AWS"
  value       = var.region
}

output "cluster_name" {
  description = "El nombre del clúster"
  value       = module.eks.cluster_name
}
