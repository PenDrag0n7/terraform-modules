### Variables ###
variable "name" {
  type = string
  description = "The name of the Recovery Services Vault."
  validation {
    condition = length(var.name) >= 2 && length(var.name) <= 50 && can(regex("^[a-zA-Z][a-zA-Z0-9-]*$", var.name))
    error_message = "Recovery Service Vault name must be 2 - 50 characters long, start with a letter, contain only letters, numbers and hyphens."
  }
}


variable "location" {
  type = string
  description = "The location/region where the Recovery Services Vault should be created."
}

variable "resource_group_name" {
  type = string
  description = "value of the resource group name"
}

variable "sku" {
  type = string
  default = "Standard"
  description = "The SKU of the Recovery Services Vault."
}

variable "soft_delete_enabled" {
  type = bool
  default = true
  description = "Should soft delete be enabled for this Recovery Services Vault?"
}

variable "soft_delete_retention_in_days" {
  type = number
  default = 14
  description = "The number of days that recovery points should be retained for soft delete purposes."
  
}

variable "public_network_access_enabled" {
  type = bool
  default = true
  description = "Should public network access be enabled for this Recovery Services Vault?"
}

variable "tags" {
  type = map
  default = {}
  description = "A mapping of tags to assign to the resource."
}

# variable "storage_mode_type" {
#   type = string
#   default = "GeoRedundant"
#   description = "The storage mode for the Recovery Services Vault."
# }