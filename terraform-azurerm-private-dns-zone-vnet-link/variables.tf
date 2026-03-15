variable "name" {
  type = string
  description = "*(Required) The name to give the link between private DNS zone and virtual network"
}

# variable "virtual_network_name" {
#   type = string
#   description = "(Required) The name of the Virtual Network that should be linked to the DNS Zone."
# }

# variable "virtual_network_resource_group_name" {
#   type = string
#   description = "(Required) The name of the resource group that contains the Virtual Network that should be linked to the DNS Zone."
# }

variable "virtual_network_id" {
  type = string
  description = "(Required) The ID of the Virtual Network that should be linked to the DNS Zone."
}


variable "private_dns_zone_name" {
  type = string
  description = "(Required) The name of the private DNS Zone."
}

variable "private_dns_zone_resource_group_name" {
  type = string
  description = "(Required) The name of the resource group that contains the private DNS Zone."
}

variable "tags" {
  type = map(string)
  default = {}
  description = "A map of tags for this resource"
}
