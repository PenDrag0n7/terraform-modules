variable name {
  type = string
  description = "(Required) The name of the elastic pool. This needs to be globally unique. Changing this forces a new resource to be created."
}

variable resource_group_name {
  type = string
  description = "(Required) The name of the resource group in which to create the elastic pool. This must be the same as the resource group of the underlying SQL server."
}

variable location {
  type = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable server_name {
  type = string
  description = "(Required) The name of the SQL Server on which to create the elastic pool. Changing this forces a new resource to be created."
}

variable server_id {
  type = string
  description = "(Required) The ID of the SQL Server on which to create the elastic pool."
}

variable sku {
  type = object({
    name = string
    capacity = string
    tier = string
    family = string
  })
  description = "(Required) A `sku` block"
}

variable per_database_settings {
  type = object({
    min_capacity = number
    max_capacity = number
  })
  description = "(Required) A `per_database_settings` block"
}

variable max_size_gb {
  type = number
  default = 4.8828125
  description = "(Optional) The max data size of the elastic pool in gigabytes. Defaults to `4.8828125`"
}

variable zone_redundant {
  type = bool
  default = false
  description = " (Optional) Whether or not this elastic pool is zone redundant. Tier needs to be `Premium` for DTU based or `BusinessCritical` for vCore based sku. Defaults to `false`."
}

variable "databases" {
  type = map(object({
    name                      = string
    max_size_gb               = number
    storage_account_type      = string
  }))
  description = "(Optional) A map of databases to create within this elastic pool"
  default = {}
}

variable "tags" {
  type = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default = {}
}
