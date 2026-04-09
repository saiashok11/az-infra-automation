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
  #   resource_group_name  = "tf-backend-rg-new"
  #   storage_account_name = "mystgaccount091d2ce85"
  #   container_name       = "mytfstatecontainer"
  #   key                  = "terraform.tfstate"
  # }
}
