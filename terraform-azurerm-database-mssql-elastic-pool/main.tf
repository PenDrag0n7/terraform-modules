resource "azurerm_mssql_elasticpool" "epool" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  server_name         = var.server_name
  max_size_gb         = var.max_size_gb

  sku {
    name     = var.sku.name
    tier     = var.sku.tier
    family   = var.sku.family
    capacity = var.sku.capacity
  }

  per_database_settings {
    min_capacity = var.per_database_settings.min_capacity
    max_capacity = var.per_database_settings.max_capacity
  }

  tags = merge({
    managed    = true
    managed_by = "terraform"
  }, var.tags)
}
