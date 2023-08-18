output "cluster_a_name" {
  description = "El nombre del clúster a"
  value       = resource.google_container_cluster.gke_a.name
}
output "cluster_b_name" {
  description = "El nombre del clúster b"
  value       = resource.google_container_cluster.gke_b.name
}
output "membership_a_name" {
  description = "El nombre de la membresía del clúster a"
  value       = resource.google_gke_hub_membership.gke_membership_a.name
}
output "membership_b_name" {
  description = "El nombre de la membresía del clúster b"
  value       = resource.google_gke_hub_membership.gke_membership_b.name
}