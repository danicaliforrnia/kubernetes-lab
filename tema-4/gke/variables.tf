variable "project_id" {
  description = "El ID del proyecto donde estará el clúster"
}

variable "region" {
  description = "La región donde estará el clúster"
}


variable "gke_username" {
  default     = ""
  description = "El nombre de usuario de GKE"
}

variable "gke_password" {
  default     = ""
  description = "La ontraseña del usuario de GKE"
}

variable "gke_num_nodes" {
  default     = 2
  description = "El número de nodos"
}