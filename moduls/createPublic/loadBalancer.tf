
# Create a public IP address for LB.
resource "azurerm_public_ip" "BootcampTerraformPublic_ipLB" {
    name                  = "${var.resource_prefix}-IpLB"
    location              = "${var.location}"
    resource_group_name   = "${var.resource_group_name}"
    sku                     = "Standard"
    allocation_method       = "Static"

    tags                  = "${var.tags}"
}
# LB from public subnet
resource "azurerm_lb" "BootcampTerraformLB" {
  name                    = "${var.resource_prefix}-LB"
  location                = "${var.location}"
  resource_group_name     = "${var.resource_group_name}"
  sku                     = "Standard"
  sku_tier                = "Regional"
  frontend_ip_configuration {
    name                  = "frontend-ip"
    public_ip_address_id  = "${azurerm_public_ip.BootcampTerraformPublic_ipLB.id}"
  }
}

# Backend pool from LB
resource "azurerm_lb_backend_address_pool" "BootcampTerraformPool" {
  loadbalancer_id         = "${azurerm_lb.BootcampTerraformLB.id}"
  name                    = "${var.resource_prefix}-Pool"
}

# Pool addresses from LB
resource "azurerm_lb_backend_address_pool_address" "BootcampTerraformPublic_vm1_address" {
  count                   = length(azurerm_network_interface.BootcampTerraformPublic_nic[*].private_ip_address)
  name                    = "${var.resource_prefix}-Public_vm_address-${count.index + 1}"
  backend_address_pool_id = "${azurerm_lb_backend_address_pool.BootcampTerraformPool.id}"
  virtual_network_id      = "${azurerm_virtual_network.BootcampTerrafotmVnet.id}"
  ip_address              = element(azurerm_network_interface.BootcampTerraformPublic_nic[*].private_ip_address, count.index)
}

# LB rule 8080
resource "azurerm_lb_rule" "BootcampTerraformLB" {
  loadbalancer_id                = "${azurerm_lb.BootcampTerraformLB.id}"
  name                           = "${var.resource_prefix}-LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 8080
  backend_port                   = 8080
  frontend_ip_configuration_name = "frontend-ip"
  backend_address_pool_ids       = [ "${azurerm_lb_backend_address_pool.BootcampTerraformPool.id}" ]
}