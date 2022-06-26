# Create private subnet DataBase.
resource "azurerm_subnet" "BootcampTerraformPrivate_subnet" {
  name                      = "${var.resource_prefix}-prvt-sn001"
  resource_group_name       = "${var.resource_group_name}"
  virtual_network_name      = azurerm_virtual_network.BootcampTerrafotmVnet.name
  address_prefixes          = [var.subnetPrivateCIDRS]
}

resource "azurerm_private_dns_zone" "BootcampPrivatDns" {
  name                = "Bootcamp54321.postgres.database.azure.com"
  resource_group_name = "${var.resource_group_name}"
}

resource "azurerm_private_dns_zone_virtual_network_link" "BootcampTerraformNetLink" {
  name                  = "BootcampTerraform54321.com"
  private_dns_zone_name = azurerm_private_dns_zone.BootcampPrivatDns.name
  virtual_network_id    = "${azurerm_virtual_network.BootcampTerrafotmVnet.id}"
  resource_group_name   = "${var.resource_group_name}"
}

resource "azurerm_postgresql_flexible_server" "BootcampPostgresqlServer" {
  name                   = "bootcamppostsqlsrv"
  resource_group_name    = "${var.resource_group_name}"
  location               = "${var.location}"
  version                = "13"
  delegated_subnet_id    = azurerm_subnet.BootcampTerraformPrivate_subnet.id
  private_dns_zone_id    = azurerm_private_dns_zone.BootcampPrivatDns.id
  administrator_login    = "${var.usernameDb}"
  administrator_password = "${var.passwordDb}"
  zone                   = "1"

  storage_mb = 32768

  sku_name   = "B_Standard_B1ms"

}