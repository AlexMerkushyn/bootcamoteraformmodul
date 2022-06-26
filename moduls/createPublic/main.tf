# Create virtual network with public and private subnets.
resource "azurerm_virtual_network" "BootcampTerrafotmVnet" {
    name                    = "${var.resource_prefix}-Vnet"
    address_space           = [var.vnetCIDRS]
    location                = "${var.location}"
    resource_group_name     = "${var.resource_group_name}"

    tags = "${var.tags}"
}

# Create public subnet. The same number of subnet is created as the number of ip in variable "subnetCIDRS"
resource "azurerm_subnet" "BootcampTerraformPublic-sbn" {
  count                     = length(var.subnetCIDRS)
  name                      = "${var.resource_prefix}-Pblc-sbn-${count.index + 1}"
  resource_group_name       = "${var.resource_group_name}"
  virtual_network_name      = "${azurerm_virtual_network.BootcampTerrafotmVnet.name}"
  address_prefixes          = [var.subnetCIDRS[count.index]]
}

# Availability set
resource "azurerm_availability_set" "BootcampTerraformSet" {
  name                         = "${var.resource_prefix}-set"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group_name}"
  platform_fault_domain_count  = 3
  platform_update_domain_count = 3  
}

# Rendom password from ubuntu administrator
  resource "random_password" "my_password" {
  length  = 10
  special = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}