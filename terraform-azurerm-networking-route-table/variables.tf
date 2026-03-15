### Variables ###
variable "name" {
  type        = string
  description = "The name of the routing table"
}

variable "location" {
  type        = string
  description = "The location/region where the virtual network is created."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the virtual network."
}

variable "link_subnet" {
  type        = bool
  description = "Should the route table be associated with a subnet?"
  default     = false
}

variable "subnet_id" {
  type        = string
  description = "The ID of the subnet to associate with the route table."
  default     = null
}

variable "disable_bgp_route_propagation" {
  type        = bool
  description = "Should BGP route propagation be disabled?"
  default     = false
}

variable "tags" {
  type        = map(any)
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "routes" {
  type = map(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  description = "A mapping of routes to assign to the route table."
  default     = {}
}
