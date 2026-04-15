# Azure VM Terraform Outputs
# ============================================================================
# This file defines output values that will be displayed after deployment
# ============================================================================

# Resource Group Outputs

# output "backend_resource_group_id" {
#   description = "ID of the backend resource group"
#   value       = azurerm_resource_group.backend.id
# }

# output "backend_resource_group_name" {
#   description = "Name of the backend resource group"
#   value       = azurerm_resource_group.backend.name
# }

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

output "subnet_ids" {
  description = "IDs of the subnets"
  value       = azurerm_subnet.websubnets[*].id
}

output "subnet_names" {
  description = "Names of the subnets"
  value       = azurerm_subnet.websubnets[*].name
}

output "subnet_address_prefixes" {
  description = "Address prefixes of the subnets"
  value       = azurerm_subnet.websubnets[*].address_prefixes
}

# Network Interface Outputs

output "network_interface_ids" {
  description = "IDs of the network interfaces"
  value       = azurerm_network_interface.nics[*].id
}

output "network_interface_private_ips" {
  description = "Private IP addresses of the network interfaces"
  value       = azurerm_network_interface.nics[*].private_ip_address
}

# Virtual Machine Outputs

output "vm_ids" {
  description = "IDs of the virtual machines"
  value       = azurerm_linux_virtual_machine.vms[*].id
}

output "vm_names" {
  description = "Names of the virtual machines"
  value       = azurerm_linux_virtual_machine.vms[*].name
}

output "vm_private_ips" {
  description = "Private IP addresses of the virtual machines"
  value       = azurerm_network_interface.nics[*].private_ip_address
}

# Load Balancer Outputs

output "load_balancer_id" {
  description = "ID of the load balancer"
  value       = azurerm_lb.lb.id
}

output "load_balancer_name" {
  description = "Name of the load balancer"
  value       = azurerm_lb.lb.name
}

output "load_balancer_public_ip" {
  description = "Public IP address of the load balancer"
  value       = azurerm_public_ip.lb_public_ip.ip_address
}

output "load_balancer_backend_pool_id" {
  description = "ID of the load balancer backend pool"
  value       = azurerm_lb_backend_address_pool.backend_pool.id
}

output "load_balancer_frontend_ip_configuration" {
  description = "Frontend IP configuration of the load balancer"
  value       = azurerm_lb.lb.frontend_ip_configuration[0].id
}

# output "vm_name" {
#   description = "Name of the virtual machine"
#   value       = azurerm_virtual_machine.example.name
# }

# output "vm_size" {
#   description = "Size of the virtual machine"
#   value       = azurerm_virtual_machine.example.vm_size
# }

# output "vm_private_ip" {
#   description = "Private IP address of the virtual machine"
#   value       = azurerm_network_interface.example.private_ip_addresses[0]
# }

# output "vm_admin_username" {
#   description = "Admin username for the virtual machine"
#   value       = [for profile in azurerm_virtual_machine.example.os_profile : profile.admin_username][0]
#   sensitive   = true
# }

# Storage Account Outputs

# output "storage_account_id" {
#   description = "ID of the storage account"
#   value       = azurerm_storage_account.tfstate.id
# }

# output "storage_account_name" {
#   description = "Name of the storage account"
#   value       = azurerm_storage_account.tfstate.name
# }

# output "storage_account_primary_blob_endpoint" {
#   description = "Primary blob endpoint of the storage account"
#   value       = azurerm_storage_account.tfstate.primary_blob_endpoint
# }

# Storage Container Outputs

# output "storage_container_id" {
#   description = "ID of the storage container"
#   value       = azurerm_storage_container.tfstate.id
# }

# output "storage_container_name" {
#   description = "Name of the storage container"
#   value       = azurerm_storage_container.tfstate.name
# }

# Summary Output

# output "deployment_summary" {
#   description = "Summary of deployed resources"
#   value = {
#     resource_group     = azurerm_resource_group.example.name
#     virtual_machine    = azurerm_virtual_machine.example.name
#     virtual_network    = azurerm_virtual_network.example.name
#     storage_account    = azurerm_storage_account.tfstate.name
#     backend_rg         = azurerm_resource_group.backend.name
#     location           = azurerm_resource_group.example.location
#   }
# }
