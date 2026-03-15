variable "name" {
  description = "(Required) The name of the virtual network. Changing this forces a new resource to be created. "
  type        = string
  validation {
    condition     = length(var.name) >= 2 && length(var.name) <= 80
    error_message = "vnet_name must be between 2 and 80 characters."
  }
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the virtual network. Changing this forces a new resource to be created."
  type        = string
  validation {
    condition     = length(var.resource_group_name) >= 1 && length(var.resource_group_name) <= 80
    error_message = "vnet_resource_group_name must be between 1 and 80 characters."
  }
}

variable "location" {
  description = "(Required) The location/region where the virtual network is created. Changing this forces a new resource to be created. "
  type        = string
  validation {
    condition     = var.location == "australiaeast" || var.location == "australiasoutheast" || var.location == "australiacentral" || var.location == "australiacentral2"
    error_message = "location must be in australiaeast, australiasoutheast, australiacentral, or australiacentral2."
  }
}

variable "address_space" {
  description = "(Required) The address space that is used the virtual network. You can supply more than one address space in a list."
  type        = list(string)
  validation {
    condition     = alltrue([for space in var.address_space : can(cidrnetmask(space))])
    error_message = "address_space must be a valid CIDR block address."
  }
}

variable "dns_servers" {
  description = "The DNS servers to be used with vnet. If no values specified, this defaults to Azure DNS."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "The tags to associate with your network and subnets."
  type        = map(string)
  default     = {}
}

## Validated in child modules
variable "subnets" {}
