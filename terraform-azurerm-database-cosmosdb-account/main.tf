resource "azurerm_cosmosdb_account" "db" {
  name                                  = var.name
  location                              = var.location
  resource_group_name                   = var.resource_group_name
  offer_type                            = var.offer_type
  kind                                  = var.kind
  enable_automatic_failover             = var.enable_automatic_failover
  ip_range_filter                       = var.ip_range_filter
  public_network_access_enabled         = var.public_network_access_enabled
  network_acl_bypass_for_azure_services = var.network_acl_bypass_for_azure_services
  network_acl_bypass_ids                = var.network_acl_bypass_ids

  dynamic "virtual_network_rule" {
    for_each = var.virtual_network_rules
    iterator = each

    content {
      id                                   = each.id
      ignore_missing_vnet_service_endpoint = each.ignore_missing_vnet_service_endpoint
    }
  }

  backup {
    type                = var.backup_type
    interval_in_minutes = var.backup_interval_in_minutes
    retention_in_hours  = var.backup_retention_in_hours
  }

  consistency_policy {
    consistency_level       = var.consistency_policy_level
    max_interval_in_seconds = var.consistency_policy_max_interval
    max_staleness_prefix    = var.consistency_policy_max_staleness_prefix
  }

  geo_location {
    location          = var.location
    failover_priority = 0
  }
}
