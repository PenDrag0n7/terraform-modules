resource "azurerm_resource_group" "rg" {
  name     = var.name
  location = var.location
  tags = merge({
    managed       = true
    managed_by    = "terraform"
  }, var.tags)
}
