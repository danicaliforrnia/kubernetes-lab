output "region" {
  value       = var.region
  description = "La región del clúster"
}

output "project_id" {
  value       = var.project_id
  description = "El ID del proyecto donde esta el clúster"
}

output "kubernetes_cluster_name" {
  value       = google_container_cluster.primary.name
  description = "El nombre del clúster en GKE"
}

output "kubernetes_cluster_host" {
  value = google_container_cluster.primary.endpoint
}
