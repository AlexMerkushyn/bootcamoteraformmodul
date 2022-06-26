# Create public ip to all public VM
resource "azurerm_public_ip" "BootcampTerraformPublic_ip" {
    count                      = length(var.subnetCIDRS)
    name                       = "${var.resource_prefix}-Ip-${count.index + 1}"
    location                   = "${var.location}"
    resource_group_name        = "${var.resource_group_name}"
    sku                        = "Standard"
    allocation_method          = "Static"

    tags = "${var.tags}"
}

resource "azurerm_network_interface" "BootcampTerraformPublic_nic" {
    count                     = length(var.subnetCIDRS)
    name                      = "${var.resource_prefix}-Pblc-nic-${count.index + 1}"
    location                  = "${var.location}"
    resource_group_name       = "${var.resource_group_name}"

    ip_configuration {
        name                          = "${var.resource_prefix}-Pblc-nic-cfg-${count.index + 1}"
        subnet_id                     = element(azurerm_subnet.BootcampTerraformPublic-sbn[*].id, count.index)
        private_ip_address_allocation = "Dynamic"
        public_ip_address_id          = azurerm_public_ip.BootcampTerraformPublic_ip[count.index].id
    }

    tags = "${var.tags}"
}