resource "azurerm_public_ip_prefix" "pfx" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.sku
  ip_version          = var.ip_version
  prefix_length       = var.prefix_length
  zones               = var.zones
  tags = merge({
    managed    = true
    managed_by = "terraform"
  }, var.tags)
}
