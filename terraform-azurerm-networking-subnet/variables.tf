variable "name" {
  description = "(Required) The name of the subnet. Changing this forces a new resource to be created."
  type        = string
  validation {
    condition     = length(var.name) >= 2 && length(var.name) <= 80
    error_message = "name must be between 2 and 80 characters."
  }
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the subnet. Changing this forces a new resource to be created."
  type        = string
  validation {
    condition     = length(var.resource_group_name) >= 1 && length(var.resource_group_name) <= 80
    error_message = "resource_group_name must be between 2 and 80 characters."
  }
}

variable "location" {
  description = "(Required) The location/region where the subnet is created. Changing this forces a new resource to be created"
  type        = string
  validation {
    condition     = var.location == "australiaeast" || var.location == "australiasoutheast" || var.location == "australiacentral" || var.location == "australiacentral2"
    error_message = "location must be in australiaeast, australiasoutheast, australiacentral, or australiacentral2."
  }
}

variable "virtual_network_name" {
  description = "(Required) The name of the virtual network to which to attach the subnet. Changing this forces a new resource to be created."
  type        = string
  validation {
    condition     = length(var.virtual_network_name) >= 2 && length(var.virtual_network_name) <= 80
    error_message = "virtual_network_name must be between 2 and 80 characters."
  }
}

variable "address_prefixes" {
  description = "(Required) The address prefixes to use for the subnet."
  type        = list(string)
  validation {
    condition     = alltrue([for space in var.address_prefixes : can(cidrnetmask(space))])
    error_message = "address_prefixes must be a valid CIDR block address."
  }
}

variable "private_endpoint_network_policies_enabled" {
  description = "(Optional) Enable or Disable network policies for the private endpoint on the subnet. Setting this to true will Enable the policy and setting this to false will Disable the policy. Default: true."
  type        = bool
  default     = true
}

variable "delegations" {
  type = map(
    object({
      name                    = string
      service_delegation_name = string
      actions                 = list(string)
    })
  )
  description = "(Optional) One or more delegation blocks as defined in the terraform docs."
  default     = {}
}

variable "service_endpoints" {
  description = "(Optional) The list of Service endpoints to associate with the subnet."
  type        = list(string)
  default     = []
  # validation {
  #   condition     = var.service_endpoints == "Microsoft.AzureActiveDirectory" || var.service_endpoints == "Microsoft.AzureCosmosDB" || var.service_endpoints == "Microsoft.ContainerRegistry" || var.service_endpoints == "Microsoft.EventHub" || var.service_endpoints == "Microsoft.KeyVault" || var.service_endpoints == "Microsoft.ServiceBus" || var.service_endpoints == "Microsoft.Sql" || var.service_endpoints == "Microsoft.Storage" || var.service_endpoints == "Microsoft.Storage.Global" || var.service_endpoints == "Microsoft.Web"
  #   error_message = "Possible values include: Microsoft.AzureActiveDirectory, Microsoft.AzureCosmosDB, Microsoft.ContainerRegistry, Microsoft.EventHub, Microsoft.KeyVault, Microsoft.ServiceBus, Microsoft.Sql, Microsoft.Storage, Microsoft.Storage.Global and Microsoft.Web."
  # }
}


## Validated in child modules
variable "nsg" {}
variable "route_table" {}

variable "link_subnet" {
  description = "(Optional) Set to false to not link the nsg and subnet"
  type        = bool
  default     = true
}

variable "tags" {
  type    = map(string)
  default = {}
}