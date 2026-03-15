locals {
  azuread_admin = var.azuread_administrator.login_username == null ? {} : {
    aad = {
      login_username              = var.azuread_administrator.login_username
      object_id                   = var.azuread_administrator.object_id
      tenant_id                   = var.azuread_administrator.tenant_id
      azuread_authentication_only = false
    }    
  }
  merged_tags = merge({
    managed    = true
    managed_by = "terraform"
  }, var.tags)
}

resource "random_password" "pw" {
  length  = 24
  special = true
}

resource "azurerm_mssql_server" "sqlserver" {
  name                          = var.name
  resource_group_name           = var.resource_group_name
  location                      = var.location
  version                       = var.server_version
  administrator_login           = var.administrator_login
  administrator_login_password  = coalesce(var.administrator_login_password, random_password.pw.result)
  minimum_tls_version           = var.minimum_tls_version
  public_network_access_enabled = var.public_network_access_enabled

  identity {
    type = "SystemAssigned"
  }

  dynamic "azuread_administrator" {
    for_each = local.azuread_admin
    iterator = each

    content {
      login_username  = each.value.login_username
      object_id       = each.value.object_id
      tenant_id       = each.value.tenant_id
    }
  }  

  tags = local.merged_tags

  lifecycle {
    ignore_changes = [
      identity
    ]
  }
}


module "database" {
 source = "../terraform-azurerm-database-mssql-database"
 for_each             = var.databases
 name                 = each.value.name
 server_id            = azurerm_mssql_server.sqlserver.id
 storage_account_type = each.value.storage_account_type
 max_size_gb          = each.value.max_size_gb
 sku_name             = each.value.sku_name
}
