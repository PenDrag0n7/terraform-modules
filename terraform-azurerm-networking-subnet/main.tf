resource "azurerm_subnet" "sn" {
  name                                      = var.name
  resource_group_name                       = var.resource_group_name
  virtual_network_name                      = var.virtual_network_name
  address_prefixes                          = var.address_prefixes
  private_endpoint_network_policies_enabled = var.private_endpoint_network_policies_enabled

  dynamic "delegation" {
    for_each = var.delegations
    content {
      name = delegation.value["name"]

      service_delegation {
        name    = delegation.value["service_delegation_name"]
        actions = delegation.value["actions"]
      }
    }
  }
  service_endpoints = try(var.service_endpoints, [])
}

module "subnetNsg" {
  source              = "../terraform-azurerm-networking-security-group"
  depends_on          = [azurerm_subnet.sn]
  count               = var.nsg == null ? 0 : 1
  name                = try(var.nsg.name, null) == null ? "nsg_sn_${var.name}" : var.nsg.name
  resource_group_name = var.resource_group_name
  location            = var.location
  security_rules      = try(var.nsg.security_rules, {})
  link_subnet         = try(var.link_subnet, true)
  subnet_id           = azurerm_subnet.sn.id
  tags                = merge(try(var.nsg.tags, {}), var.tags)
}

module "routing" {
  source                        = "../terraform-azurerm-networking-route-table"
  depends_on                    = [azurerm_subnet.sn]
  count                         = var.route_table == null ? 0 : 1
  name                          = try(var.route_table.name, null) == null ? "rt_sn_${var.name}" : var.route_table.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  routes                        = try(var.route_table.routes, {})
  disable_bgp_route_propagation = try(var.route_table.disable_bgp_route_propagation, false)
  link_subnet                   = try(var.link_subnet, true)
  subnet_id                     = var.link_subnet == false ? null : azurerm_subnet.sn.id
  tags                          = merge(try(var.route_table.tags, {}), var.tags)
}
