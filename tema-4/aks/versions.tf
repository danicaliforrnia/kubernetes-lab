terraform {
  
  cloud {
    workspaces {
      name = "terraform-aks"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "2.66.0"
    }
  }

  required_version = ">= 0.14"
}
