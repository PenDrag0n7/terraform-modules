resource "azurerm_key_vault" "kv" {
  name                       = var.name
  location                   = var.location
  resource_group_name        = var.resource_group_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days = var.soft_delete_retention_days
  purge_protection_enabled   = var.purge_protection_enabled
  sku_name                   = var.sku_name
  enable_rbac_authorization  = var.enable_rbac_authorization
  
  network_acls {
    bypass                      = var.network_acls.bypass
    default_action              = var.network_acls.default_action
    ip_rules                    = var.network_acls.ip_rules
    virtual_network_subnet_ids  = var.network_acls.virtual_network_subnet_ids
  }
  
  tags = var.tags
}
