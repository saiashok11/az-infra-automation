# Azure VM Terraform Variables
# ============================================================================
# This file defines all configurable parameters for the Azure VM deployment.
# All values can be overridden via terraform.tfvars or CLI arguments.
# ============================================================================

# Resource Group Variables

variable "resource_group_name" {
  description = "Name of the resource group for main application resources"
  type        = string
  default     = "RG01"
}

variable "location" {
  description = "Azure region for resources"
  type        = string
  default     = "West Europe"
}

# Virtual Network Variables

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
  default     = "Vnet01"
}

variable "address_space" {
  description = "Address space for virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

# Subnet Variables

variable "subnet_names" {
  description = "Names of the subnets"
  type        = list(string)
  default     = ["webSubnet01", "webSubnet02"]
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

# Network Interface Variables

variable "network_interface_names" {
  description = "Names of the network interfaces"
  type        = list(string)
  default     = ["NIC01", "NIC02"]
}

# Virtual Machine Variables

variable "vm_names" {
  description = "Names of the virtual machines"
  type        = list(string)
  default     = ["webserver01", "webserver02"]
}

variable "vm_size" {
  description = "Size of the virtual machines"
  type        = string
  default     = "Standard_B2s"
}

variable "vm_admin_username" {
  description = "Admin username for VMs"
  type        = string
  default     = "azureuser"
}

variable "vm_admin_password" {
  description = "Admin password for VMs (from GitHub secrets AZURE_PASS)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "os_disk_caching" {
  description = "Caching type for OS disk"
  type        = string
  default     = "ReadWrite"
}

variable "os_disk_storage_account_type" {
  description = "Storage account type for OS disk"
  type        = string
  default     = "Premium_LRS"
}

# Load Balancer Variables

variable "load_balancer_name" {
  description = "Name of the load balancer"
  type        = string
  default     = "LB01"
}

variable "lb_frontend_ip_name" {
  description = "Name of load balancer frontend IP"
  type        = string
  default     = "LBFrontendIP"
}

variable "lb_backend_pool_name" {
  description = "Name of load balancer backend pool"
  type        = string
  default     = "LBBackendPool"
}

variable "lb_rule_name" {
  description = "Name of load balancer rule"
  type        = string
  default     = "HTTPRule"
}

variable "lb_probe_name" {
  description = "Name of load balancer health probe"
  type        = string
  default     = "HTTPProbe"
}

# Storage Account & Terraform Backend Variables

# variable "storage_account_name" {
#   description = "Name of the storage account for Terraform state"
#   type        = string
#   default     = ""
# }

# variable "storage_container_name" {
#   description = "Name of the storage container for Terraform state"
#   type        = string
#   default     = ""
# }

# variable "backend_resource_group_name" {
#   description = "Resource group name for storage account"
#   type        = string
#   default     = ""
# }

# Environment Tag

variable "environment_tag" {
  description = "Environment tag for resources"
  type        = string
  default     = "production"
}
