terraform {
  required_providers {
    azurerm = {
      source                = "hashicorp/azurerm"
      version               = "=3.0.0"
    }
  }
}
provider "azurerm" {
  features {}
}

# # Rendom password from ubuntu administrator
#   resource "random_password" "my_password" {
#   length  = 10
#   special = true
#   override_special = "!#$%&*()-_=+[]{}<>:?"
# }

# Create a resource group if it doesn’t exist.
resource "azurerm_resource_group" "BootcampTerraformRG" {
    name                    = "${var.resource_prefix}-RG"
    location                = "${var.location}"
    tags                    = "${var.tags}"
}


module "public_subnetStaging" {
  source = "./moduls/createPublic"
  resource_group_name = "${azurerm_resource_group.BootcampTerraformRG.name}"
  resource_prefix = "BootcampStaging"
}

module "public_subnetProduction" {
  source = "./moduls/createPublic"
  resource_group_name = "${azurerm_resource_group.BootcampTerraformRG.name}"
  resource_prefix = "BootcampProduction"
  vnetCIDRS = "10.1.0.0/16"
  subnetPrivateCIDRS = "10.1.20.0/24"
  subnetCIDRS = [
    "10.1.1.0/24",
    "10.1.2.0/24",
    "10.1.3.0/24"
  ]
}

# module "privet_subnet" {
#   source = "./moduls/createPrivate"
#   resource_group_name = "${azurerm_resource_group.BootcampTerraformRG.name}"
#   BootcampTerrafotmVnet_name = module.public_subnet.BootcampTerrafotmVnet_name
# }