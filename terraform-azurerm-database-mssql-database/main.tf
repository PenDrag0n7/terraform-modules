resource "azurerm_mssql_database" "db" {
  name                  = var.name
  server_id             = var.server_id
  max_size_gb           = var.max_size_gb
  sku_name              = var.sku_name
  storage_account_type  = var.storage_account_type
  elastic_pool_id       = var.elastic_pool_id
  tags = merge({
    managed    = true
    managed_by = "terraform"
  }, var.tags)
}
