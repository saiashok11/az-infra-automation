# Terraform configuration and required providers

terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  # Uncomment below after creating resources in Azure
  # backend "azurerm" {
  #   resource_group_name  = var.backend_resource_group_name
  #   storage_account_name = var.storage_account_name
  #   container_name       = var.storage_container_name
  #   key                  = "terraform.tfstate"
  # }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}
