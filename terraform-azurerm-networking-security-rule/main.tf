locals {
  source_port_range = var.source_port_ranges == null ? var.source_port_range : null
}


resource "azurerm_network_security_rule" "nsr" {
  name                        = var.use_access_name_prefix ? "${var.access}_${var.name}" : var.name
  priority                    = var.priority
  direction                   = var.direction
  access                      = var.access
  protocol                    = var.protocol
  description                 = var.description
  source_port_range           = local.source_port_range
  source_port_ranges          = var.source_port_ranges
  destination_port_ranges     = var.destination_port_ranges
  source_address_prefix       = var.source_address_prefix
  destination_address_prefix  = var.destination_address_prefix
  resource_group_name         = var.resource_group_name
  network_security_group_name = var.network_security_group_name
}
