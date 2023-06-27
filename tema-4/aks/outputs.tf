output "resource_group_name" {
  description = "El nombre del grupo de recursos"
  value       = azurerm_resource_group.default.name
}

output "kubernetes_cluster_name" {
  description = "El nombre del clúster"
  value       = azurerm_kubernetes_cluster.default.name
}