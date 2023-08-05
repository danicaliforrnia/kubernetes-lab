variable "project_id" {
  description = "El ID del proyecto donde estará el clúster"
}

variable "region" {
  default = "europe-west2-a"
  description = "La región donde estará el clúster"
}

variable "gke_num_nodes" {
  default     = 1
  description = "El número de nodos"
}