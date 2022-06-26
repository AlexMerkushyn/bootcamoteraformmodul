# Create network security group and SSH rule for public subnet.
resource "azurerm_network_security_group" "BootcampTerraformPublic_nsg" {
  name                         = "${var.resource_prefix}-Pblc-nsg"
  location                     = "${var.location}"
  resource_group_name          = "${var.resource_group_name}"

  # Allow SSH traffic in from Internet to public subnet.
  security_rule {
    name                       = "allow-ssh-all"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  security_rule {
    name                       = "allow-8080-all"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "8080"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = "${var.tags}"
}

# Associate network security group with all public subnet.
resource "azurerm_subnet_network_security_group_association" "BootcampTerraformPublic_subnet_assoc" {
  count                        = length(azurerm_subnet.BootcampTerraformPublic-sbn[*].id)
  subnet_id                    = element(azurerm_subnet.BootcampTerraformPublic-sbn[*].id, count.index)
  network_security_group_id    = "${azurerm_network_security_group.BootcampTerraformPublic_nsg.id}"
}