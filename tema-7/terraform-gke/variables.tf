variable "project_id" {
  description = "El ID del proyecto donde estará el clúster"
}
variable "cluster_name" {
  description = "El nombre del clúster"
  default     = "my-gke-cluster"
}
variable "env_name" {
  description = "El ambiente en la nube"
  default     = "topic-7"
}
variable "region" {
  description = "La región donde estará el clúster"
  default     = "europe-west1"
}
variable "network" {
  description = "La red VPC creada para el clúster"
  default     = "gke-network"
}
variable "subnetwork" {
  description = "La subred creada para el clúster"
  default     = "gke-subnet"
}
variable "ip_range_pods_name" {
  description = "El rango de IPs secundarias para los Pods"
  default     = "ip-range-pods"
}
variable "ip_range_services_name" {
  description = "El rango de IPs secundarias para los Services"
  default     = "ip-range-services"
}
variable "use_account_email" {
  description = "El email del usuario con role admin en el cluster"
}