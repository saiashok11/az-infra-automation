# Azure VM Terraform Variables
# ============================================================================
# This file defines all configurable parameters for the Azure VM deployment.
# All values can be overridden via terraform.tfvars or CLI arguments.
# ============================================================================

# Resource Group Variables

variable "resource_group_name" {
  description = "Name of the resource group for main application resources"
  type        = string
  default     = "MYRG012"
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
  default     = "myVnet01"
}

variable "address_space" {
  description = "Address space for virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
  default     = "mySubnet01"
}

variable "subnet_address_prefixes" {
  description = "Address prefixes for subnet"
  type        = list(string)
  default     = ["10.0.2.0/24"]
}

variable "network_interface_name" {
  description = "Name of the network interface"
  type        = string
  default     = "myNIC01"
}

# Virtual Machine Variables

variable "vm_name" {
  description = "Name of the virtual machine"
  type        = string
  default     = "myVM01"
}

variable "vm_size" {
  description = "Size of the virtual machine"
  type        = string
  default     = "Standard_DS1_v2"
}

# VM Image Variables

variable "image_publisher" {
  description = "Publisher of the VM image"
  type        = string
  default     = "Canonical"
}

variable "image_offer" {
  description = "Offer of the VM image"
  type        = string
  default     = "UbuntuServer"
}

variable "image_sku" {
  description = "SKU of the VM image"
  type        = string
  default     = "18.04-LTS"
}

variable "image_version" {
  description = "Version of the VM image"
  type        = string
  default     = "latest"
}

variable "os_disk_name" {
  description = "Name of the OS disk"
  type        = string
  default     = "myOSDisk01"
}

# VM Admin Credentials Variables

variable "computer_name" {
  description = "Computer name for the VM"
  type        = string
  default     = "myMachine01"
}

variable "admin_username" {
  description = "Admin username for the VM"
  type        = string
  default     = "adminuser"
  sensitive   = true
}

variable "admin_password" {
  description = "Admin password for the VM"
  type        = string
  default     = "Password123!"
  sensitive   = true
}

# Storage Account & Terraform Backend Variables

variable "storage_account_name" {
  description = "Name of the storage account for Terraform state"
  type        = string
  default     = "mystgaccount091d2ce85"
}

variable "storage_container_name" {
  description = "Name of the storage container for Terraform state"
  type        = string
  default     = "mytfstatecontainer"
}

variable "backend_resource_group_name" {
  description = "Resource group name for storage account"
  type        = string
  default     = "tf-backend-rg-new"
}

# Tags

variable "environment_tag" {
  description = "Environment tag"
  type        = string
  default     = "testing"
}
