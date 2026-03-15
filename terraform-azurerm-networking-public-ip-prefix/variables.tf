variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Public IP Prefix resource . Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the Public IP Prefix."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "sku" {
  description = "(Optional) The SKU of the Public IP Prefix. Accepted values are Standard. Defaults to Standard. Changing this forces a new resource to be created."
  default     = "Basic"
  type        = string
}

variable "ip_version" {
  description = "(Optional) The IP Version to use, IPv6 or IPv4. Changing this forces a new resource to be created. Default is IPv4."
  default = "IPv4"
  type = string
}

variable "prefix_length" {
  description = "(Optional) Specifies the number of bits of the prefix. The value can be set between 0 (4,294,967,296 addresses) and 31 (2 addresses). Defaults to 28(16 addresses). Changing this forces a new resource to be created."
  default     = 28
  type = number
}

variable "zones" {
  type        = list(string)
  description = "(Optional) Specifies a list of Availability Zones in which this Public IP Prefix should be located. Changing this forces a new Public IP Prefix to be created."
  default     = []
}

variable "tags" {
  type    = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default = {}
}
