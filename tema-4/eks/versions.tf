terraform {

  cloud {
    workspaces {
      name = "terraform-eks"
    }
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.47.0"
    }
  }

  required_version = ">= 0.14"
}

