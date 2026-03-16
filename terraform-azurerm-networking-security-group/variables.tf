variable "name" {
  type = string
  description = "(Required) Specifies the name of the network security group. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type = string
  description = "(Required) The name of the resource group in which to create the network security group. Changing this forces a new resource to be created."
}

variable "location" {
  type = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "security_rules" {
  #type = map(
  #  object({
  #    name                       = string
  #    priority                   = number
  #    direction                  = string
  #    access                     = string
  #    protocol                   = string
  #    source_port_range          = string
  #    destination_port_range     = string
  #    source_address_prefix      = string
  #    destination_address_prefix = string
  #  })
  #)
  #default = {}
  #description = "(Optional) Map of objects representing security rules"
}


variable "subnet_id" {
  type = string
  default = null
  description = "The ID of the subnet to link to, if applicable"
}

variable "link_subnet" {
  type = bool
  default = false
  description = "Set this to true if this NSG should be linked to a subnet. Required for `link_subnet_id` to function."
}

variable "tags" {
  type    = map(string)
  default = {}
}
