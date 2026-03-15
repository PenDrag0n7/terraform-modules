variable "name" {
  type = string
  description = "(Required) The name of the Microsoft SQL Server. This needs to be globally unique within Azure."
}

variable "resource_group_name" {
  type = string
  description = "(Required) The name of the resource group in which to create the Microsoft SQL Server."
}

variable "location" {
  type = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "server_version" {
  type = string
  #https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/mssql_server
  # (Required) The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server).
  default = "12.0"
  description = "(Required) The version for the new server. Valid values are: 2.0 (for v11 server) and 12.0 (for v12 server)."
}

variable "administrator_login" {
  type = string
  description = "(Required) The administrator login name for the new server. Changing this forces a new resource to be created."
}

variable "administrator_login_password" {
  type = string
  description = "(Required) The password associated with the administrator_login user. Needs to comply with Azure's Password Policy"
}

variable "minimum_tls_version" {
  type    = string
  default = "1.2"
  description = "(Optional) The Minimum TLS Version for all SQL Database and SQL Data Warehouse databases associated with the server. Valid values are: 1.0, 1.1 and 1.2."
}

variable "tags" {
  type = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
}

variable "public_network_access_enabled" {
  type = bool
  default = true
  description = "(Optional) Whether public network access is allowed for this server. Defaults to `true`."
}

variable "firewall_rules" {
  type = map(
    object({
      name                  = string
      start_ip_address      = string
      end_ip_address        = string
    })
  )
  description = "(optional) A map of firewall rules to configure for this server."
}

variable "azuread_administrator" {
  type = object({
    login_username  = string
    object_id       = string
    tenant_id       = string
  })
  default = {
    login_username = null
    object_id = null
    tenant_id = null
  }
  description = "(Optional) Configures an AAD user as the SQL administrator account"
}

variable "databases" {
 type = map(
   object({
     name                      = string
     max_size_gb               = number
     sku_name                  = string
     storage_account_type      = string
   })
 )
}

variable "elastic_pools" {
 type = map(
   object({
     name                = string
     max_size_gb         = number

     sku = object({
       name     = string
       tier     = string
       family   = string
       capacity = number
     })#

     per_database_settings = object({
       min_capacity = number
       max_capacity = number
     })
     zone_redundant = bool
     databases = map(
       object({
         name                      = string
         max_size_gb               = number
         storage_account_type      = string
       })
     )
   })
 )
}
