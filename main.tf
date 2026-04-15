# Main Application Resources

resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_virtual_network" "example" {
  name                = var.virtual_network_name
  address_space       = var.address_space
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
}

# Subnets

resource "azurerm_subnet" "websubnets" {
  count                = length(var.subnet_names)
  name                 = var.subnet_names[count.index]
  resource_group_name  = azurerm_resource_group.example.name
  virtual_network_name = azurerm_virtual_network.example.name
  address_prefixes     = [var.subnet_address_prefixes[count.index]]
}

# Public IP for Load Balancer

resource "azurerm_public_ip" "lb_public_ip" {
  name                = "LBPublicIP"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Load Balancer

resource "azurerm_lb" "lb" {
  name                = var.load_balancer_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = var.lb_frontend_ip_name
    public_ip_address_id = azurerm_public_ip.lb_public_ip.id
  }
}

# Load Balancer Backend Pool

resource "azurerm_lb_backend_address_pool" "backend_pool" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = var.lb_backend_pool_name
}

# Load Balancer Health Probe

resource "azurerm_lb_probe" "http_probe" {
  loadbalancer_id     = azurerm_lb.lb.id
  name                = var.lb_probe_name
  protocol            = "Http"
  port                = 80
  request_path        = "/"
  interval_in_seconds = 15
  number_of_probes    = 2
}

# Load Balancer Rule

resource "azurerm_lb_rule" "http_rule" {
  loadbalancer_id                = azurerm_lb.lb.id
  name                           = var.lb_rule_name
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = var.lb_frontend_ip_name
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.backend_pool.id]
  probe_id                       = azurerm_lb_probe.http_probe.id
}

# Network Interfaces

resource "azurerm_network_interface" "nics" {
  count               = length(var.network_interface_names)
  name                = var.network_interface_names[count.index]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name

  ip_configuration {
    name                          = "testConfiguration"
    subnet_id                     = azurerm_subnet.websubnets[count.index].id
    private_ip_address_allocation = "Dynamic"
  }
}

# Associate NICs with Load Balancer Backend Pool

resource "azurerm_network_interface_backend_address_pool_association" "nic_lb_association" {
  count                   = length(var.network_interface_names)
  network_interface_id    = azurerm_network_interface.nics[count.index].id
  ip_configuration_name   = "testConfiguration"
  backend_address_pool_id = azurerm_lb_backend_address_pool.backend_pool.id
}

# Virtual Machines

resource "azurerm_linux_virtual_machine" "vms" {
  count               = length(var.vm_names)
  name                = var.vm_names[count.index]
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  size                = var.vm_size

  admin_username = var.vm_admin_username

  disable_password_authentication = false
  admin_password                  = var.vm_admin_password

  network_interface_ids = [azurerm_network_interface.nics[count.index].id]

  os_disk {
    caching              = var.os_disk_caching
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  custom_data = base64encode(file("${path.module}/install_nginx.sh"))

  tags = {
    environment = var.environment_tag
    deployed_by = "Terraform"
  }
  
  depends_on = [azurerm_network_interface_backend_address_pool_association.nic_lb_association]
}
