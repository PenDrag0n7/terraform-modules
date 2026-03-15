variable "name" {
  type = string
  description = "(Required) Specifies the name of the Key Vault. Changing this forces a new resource to be created."
}

variable "location" {
  type = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type = string
  description = "(Required) The name of the resource group in which to create the Key Vault. Changing this forces a new resource to be created."
}

variable "sku_name" {
  type = string
  default = "standard"
  description = "(Optional) The Name of the SKU used for this Key Vault. Possible values are `standard` and `premium`. Defaults to `standard`"
}

variable "purge_protection_enabled" {
  type = bool
  default = false
  description = "(Optional) Is Purge Protection enabled for this Key Vault? Defaults to `false`."
}

variable "soft_delete_retention_days" {
  type = number
  default = 90
  description = "(Optional) The number of days that items should be retained for once soft-deleted. This value can be between `7` and `90` days. Defaults to `90`."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the resource group."
}

variable "enable_rbac_authorization" {
  type = bool
  default = false
  description = "(Optional) Boolean flag to specify whether Azure Key Vault uses Role Based Access Control (RBAC) for authorization of data actions. Defaults to `false`."
}

variable "network_acls" {
  type = object({
    bypass = string
    default_action = string
    ip_rules = list(string)
    virtual_network_subnet_ids = list(string)
  })
  default = null
  description = "A `network_acls` block that defines the networking configuration for this resource. Defaults to `null`."
}
