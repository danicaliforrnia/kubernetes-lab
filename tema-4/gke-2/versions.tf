terraform {
  
  cloud {
    workspaces {
      name = "terraform-gke-2"
    }
  }

  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.47.0"
    }
  }

  required_version = ">= 0.14"
}

