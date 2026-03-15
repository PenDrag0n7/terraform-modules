variable "resource_group_name" {
  type        = string
  description = "(Required) Specifies the Name of the Resource Group within which the Private Endpoint should exist. Changing this forces a new resource to be created."
}

variable "name" {
  type        = string
  description = "(Required) Specifies the Name of the Private Endpoint. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) The supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "subnet_id" {
  type        = string
  default     = null
  description = "(Required) The ID of the Subnet from which Private IP Addresses will be allocated for this Private Endpoint. Changing this forces a new resource to be created. This is not required if the subnet/vnet/resource group name are all supplied."
}

# variable "subnet_name" {
#   type        = string
#   description = "The name of the subnet from which Private IP Addresses will be allocated for this Private Endpoint. Not required if `subnet_id` is supplied."
# }

# variable "subnet_virtual_network_name" {
#   type        = string
#   description = "The name of the virtual network that contains the subnet from which Private IP Addresses will be allocated for this Private Endpoint. Not required if `subnet_id` is supplied."
# }

# variable "subnet_resource_group_name" {
#   type        = string
#   description = "The name of the resource group that holds the virtual network and subnet from which Private IP Addresses will be allocated for this Private Endpoint. Not required if `subnet_id` is supplied."
# }

variable "private_connection_resource_id" {
  type        = string
  description = "(Optional) The ID of the Private Link Enabled Remote Resource which this Private Endpoint should be connected to."
}

variable "private_connection_name" {
  type        = string
  description = "(Required) Specifies the Name of the Private Service Connection. Changing this forces a new resource to be created."
}

variable "is_manual_connection" {
  type        = bool
  default     = false
  description = "(Required) Does the Private Endpoint require Manual Approval from the remote resource owner? Changing this forces a new resource to be created."
}

variable "subresource_names" {
  type        = list(string)
  description = "(Optional) A list of subresource names which the Private Endpoint is able to connect to. subresource_names corresponds to group_id. Changing this forces a new resource to be created."
}


variable "private_dns_zone_ids" {
  type = list(string)
  description = "(Optional) A list of Private DNS Zone IDs which should be associated with this Private Endpoint. Changing this forces a new resource to be created."
}