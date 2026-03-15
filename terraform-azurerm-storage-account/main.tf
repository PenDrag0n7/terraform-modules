resource "azurerm_storage_account" "sa" {
  name                = var.name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  account_kind                     = var.account_kind
  account_tier                     = var.account_tier
  account_replication_type         = var.account_replication_type
  cross_tenant_replication_enabled = var.cross_tenant_replication_enabled
  access_tier                      = var.access_tier
  enable_https_traffic_only        = var.enable_https_traffic_only
  min_tls_version                  = var.min_tls_version
  public_network_access_enabled    = var.public_network_access_enabled
  is_hns_enabled                   = var.is_hns_enabled  
  
  network_rules {
    bypass                      = toset(var.network_rules.bypass)
    default_action              = var.network_rules.default_action
    ip_rules                    = var.network_rules.ip_rules
    virtual_network_subnet_ids  = var.network_rules.virtual_network_subnet_ids
  }
}

resource "azurerm_storage_container" "container" {
  for_each              = var.containers
  name                  = each.value.name
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = each.value.container_access_type
}
