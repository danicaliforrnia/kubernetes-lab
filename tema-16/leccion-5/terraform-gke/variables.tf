variable "project_id" {
  description = "El ID del proyecto donde estará el clúster"
}
variable "credentials" {
  description = "Credenciales de la cuenta de servicio"
  default     = "terraform.json"
}
variable "cluster_name" {
  description = "El nombre del clúster"
  default     = "gke-cluster"
}
variable "env_name" {
  description = "El ambiente en la nube"
  default     = "demo"
}
variable "region" {
  description = "La región donde estará el clúster"
  default     = "europe-west1"
}
variable "zone" {
  description = "La zona donde estará el clúster"
  default     = "europe-west1-b"
}
variable "membership_prefix" {
  description = "Prefijo de la membresía"
  default     = "my-gke-membership"
}