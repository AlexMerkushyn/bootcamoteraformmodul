output "BootcampTerrafotmVnet_name" {
  value = azurerm_virtual_network.BootcampTerrafotmVnet.name
}

output "my_password" {
  value = random_password.my_password.result
  sensitive = true
}