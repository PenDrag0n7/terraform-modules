resource "azurerm_private_dns_zone" "zone" {
  name                = var.name
  resource_group_name = var.resource_group_name

  tags = merge({
    managed    = true
    managed_by = "terraform"
  }, var.tags)
}