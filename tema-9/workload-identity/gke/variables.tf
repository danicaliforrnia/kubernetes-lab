variable "project_id" {
  description = "El ID del proyecto"
}

variable "region" {
  default = "europe-west2"
  description = "La región"
}

variable "location" {
  default = "europe-west2-a"
  description = "La zona del clúster"
}


variable "gke_num_nodes" {
  default     = 1
  description = "El número de nodos"
}