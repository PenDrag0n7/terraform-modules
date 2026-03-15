resource "azurerm_virtual_network" "vnet" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  address_space       = var.address_space
  dns_servers         = try(var.dns_servers, [])
  tags                = try(var.tags, {})
}

module "subnet" {
  source                                    = "../terraform-azurerm-networking-subnet"
  for_each                                  = var.subnets
  name                                      = each.value.name
  resource_group_name                       = var.resource_group_name
  location                                  = var.location
  virtual_network_name                      = azurerm_virtual_network.vnet.name
  address_prefixes                          = each.value.address_prefixes
  private_endpoint_network_policies_enabled = try(each.value.private_endpoint_network_policies_enabled, true)
  delegations                               = try(each.value.delegations, {})
  service_endpoints                         = try(each.value.service_endpoints, [])
  nsg                                       = try(each.value.nsg, null)
  route_table                               = try(each.value.route_table, null)
  tags                                      = try(var.tags, {})
}
