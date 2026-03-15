### Azure Route Table ###
resource "azurerm_route_table" "rt" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = var.disable_bgp_route_propagation
  tags                          = var.tags
}

### Associate Route Table to Subnet ###
module "subnet_rt_link" {
  source         = "../terraform-azurerm-networking-route-table-subnet-association"
  count          = var.link_subnet == false ? 0 : 1
  subnet_id      = var.subnet_id
  route_table_id = azurerm_route_table.rt.id
}

### Azure Route ###
resource "azurerm_route" "route" {
  for_each               = var.routes
  name                   = each.value.name
  resource_group_name    = var.resource_group_name
  route_table_name       = azurerm_route_table.rt.name
  address_prefix         = each.value.address_prefix
  next_hop_type          = each.value.next_hop_type
  next_hop_in_ip_address = try(each.value.next_hop_in_ip_address, null)
}
