resource "azurerm_public_ip" "ip" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = var.allocation_method
  sku                 = var.sku
  domain_name_label   = var.domain_name_label
  zones               = var.zones
  ip_tags             = var.ip_tags
  public_ip_prefix_id = var.public_ip_prefix_id
  tags                = var.tags
  lifecycle {
    ignore_changes = [
      domain_name_label,
      tags
    ]
  }
}
