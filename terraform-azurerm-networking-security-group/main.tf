resource "azurerm_network_security_group" "nsg" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_subnet_network_security_group_association" "subnet_nsg_link" {
  count                     = var.link_subnet == false ? 0 : 1
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

module "networkSecurityRule" {
  source                      = "../terraform-azurerm-networking-security-rule"
  depends_on                  = [azurerm_network_security_group.nsg]
  for_each                    = var.security_rules
  name                        = each.value.name
  priority                    = each.value.priority
  direction                   = each.value.direction
  access                      = each.value.access
  protocol                    = each.value.protocol
  source_port_range           = try(each.value.source_port_range, "*")
  source_port_ranges          = try(each.value.source_port_ranges, null)
  destination_port_ranges     = each.value.destination_port_ranges
  source_address_prefix       = try(each.value.source_address_prefix, "*")
  destination_address_prefix  = try(each.value.destination_address_prefix, "*")
  use_access_name_prefix      = try(each.value.use_access_name_prefix, false)
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.nsg.name
}
