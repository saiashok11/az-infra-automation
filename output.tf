# Azure VM Terraform Outputs
# ============================================================================
# This file defines output values that will be displayed after deployment
# ============================================================================

# Resource Group Outputs

output "backend_resource_group_id" {
  description = "ID of the backend resource group"
  value       = azurerm_resource_group.backend.id
}

output "backend_resource_group_name" {
  description = "Name of the backend resource group"
  value       = azurerm_resource_group.backend.name
}

output "resource_group_id" {
  description = "ID of the main resource group"
  value       = azurerm_resource_group.example.id
}

output "resource_group_name" {
  description = "Name of the main resource group"
  value       = azurerm_resource_group.example.name
}

# Virtual Network Outputs

output "vnet_id" {
  description = "ID of the virtual network"
  value       = azurerm_virtual_network.example.id
}

output "vnet_name" {
  description = "Name of the virtual network"
  value       = azurerm_virtual_network.example.name
}

output "vnet_address_space" {
  description = "Address space of the virtual network"
  value       = azurerm_virtual_network.example.address_space
}

# Subnet Outputs

output "subnet_id" {
  description = "ID of the subnet"
  value       = azurerm_subnet.example.id
}

output "subnet_name" {
  description = "Name of the subnet"
  value       = azurerm_subnet.example.name
}

output "subnet_address_prefixes" {
  description = "Address prefixes of the subnet"
  value       = azurerm_subnet.example.address_prefixes
}

# Network Interface Outputs

output "nic_id" {
  description = "ID of the network interface"
  value       = azurerm_network_interface.example.id
}

output "nic_name" {
  description = "Name of the network interface"
  value       = azurerm_network_interface.example.name
}

output "nic_private_ip" {
  description = "Private IP address of the network interface"
  value       = azurerm_network_interface.example.private_ip_addresses[0]
}

# Virtual Machine Outputs

output "vm_id" {
  description = "ID of the virtual machine"
  value       = azurerm_virtual_machine.example.id
}

output "vm_name" {
  description = "Name of the virtual machine"
  value       = azurerm_virtual_machine.example.name
}

output "vm_size" {
  description = "Size of the virtual machine"
  value       = azurerm_virtual_machine.example.vm_size
}

output "vm_private_ip" {
  description = "Private IP address of the virtual machine"
  value       = azurerm_network_interface.example.private_ip_addresses[0]
}

output "vm_admin_username" {
  description = "Admin username for the virtual machine"
  value       = [for profile in azurerm_virtual_machine.example.os_profile : profile.admin_username][0]
  sensitive   = true
}

# Storage Account Outputs

output "storage_account_id" {
  description = "ID of the storage account"
  value       = azurerm_storage_account.tfstate.id
}

output "storage_account_name" {
  description = "Name of the storage account"
  value       = azurerm_storage_account.tfstate.name
}

output "storage_account_primary_blob_endpoint" {
  description = "Primary blob endpoint of the storage account"
  value       = azurerm_storage_account.tfstate.primary_blob_endpoint
}

# Storage Container Outputs

output "storage_container_id" {
  description = "ID of the storage container"
  value       = azurerm_storage_container.tfstate.id
}

output "storage_container_name" {
  description = "Name of the storage container"
  value       = azurerm_storage_container.tfstate.name
}

# Summary Output

output "deployment_summary" {
  description = "Summary of deployed resources"
  value = {
    resource_group     = azurerm_resource_group.example.name
    virtual_machine    = azurerm_virtual_machine.example.name
    virtual_network    = azurerm_virtual_network.example.name
    storage_account    = azurerm_storage_account.tfstate.name
    backend_rg         = azurerm_resource_group.backend.name
    location           = azurerm_resource_group.example.location
  }
}
