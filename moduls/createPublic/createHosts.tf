# Create public hosts.  
resource "azurerm_virtual_machine" "BootcampTerraformPublic_vm" {
    count                 = length(azurerm_network_interface.BootcampTerraformPublic_nic[*].id)
    name                  = "${var.resource_prefix}-Pblc-vm-${count.index + 1}"
    location              = "${var.location}"
    resource_group_name   = "${var.resource_group_name}"
    availability_set_id   = "${azurerm_availability_set.BootcampTerraformSet.id}"
    network_interface_ids = [element(azurerm_network_interface.BootcampTerraformPublic_nic[*].id, count.index)]
    vm_size               = "Standard_B1s"

    storage_os_disk {
        name              = "${var.resource_prefix}-Pblc-dsk-${count.index + 1}"
        caching           = "ReadWrite"
        create_option     = "FromImage"
        managed_disk_type = "Standard_LRS"
    }

    storage_image_reference {
        publisher         = "Canonical"
        offer             = "UbuntuServer"
        sku               = "18.04-LTS"
        version           = "latest"
    }

    os_profile {
        computer_name     = "${var.resource_prefix}-Pblc-vmm-${count.index + 1}"
        admin_username    = "${var.username}"
        admin_password    = "${var.password}"
    }

    os_profile_linux_config {
        disable_password_authentication = false
    }

    tags                  = "${var.tags}"
}