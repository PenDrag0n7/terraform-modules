output "vnet" {
  value = azurerm_virtual_network.vnet
}

output "subnets" {
  value = module.subnet
}