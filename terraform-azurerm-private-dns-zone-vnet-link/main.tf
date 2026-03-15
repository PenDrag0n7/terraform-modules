# Data blocks for the existing vnet

# data "azurerm_resource_group" "rg" {
#   name = var.virtual_network_resource_group_name
# }

# data "azurerm_virtual_network" "vnet" {
#   name                = var.virtual_network_name
#   resource_group_name = data.azurerm_resource_group.rg.name
# }

# Data block for the existing private DNS zone

data "azurerm_private_dns_zone" "zone" {
  name                = var.private_dns_zone_name
  resource_group_name = var.private_dns_zone_resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "this" {
  name                  = var.name
  resource_group_name   = var.private_dns_zone_resource_group_name
  private_dns_zone_name = data.azurerm_private_dns_zone.zone.name
  virtual_network_id    = var.virtual_network_id
}
