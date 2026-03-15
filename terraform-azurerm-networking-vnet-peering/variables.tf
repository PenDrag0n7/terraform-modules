# LEFT SIDE SPECIFIC
variable "name" {  
  type = string
  description = "The name of the VNET peering"
}

variable "resource_group_name" {
  type = string
  description = "The name of the resource group in which the VNET peering will be created"
}

variable "virtual_network_name" {
  type = string
  description = "The name of the VNET in which the VNET peering will be created"
}

variable "remote_virtual_network_id" {
  type = string
  description = "The ID of the remote VNET to which the VNET peering will be created"
}

variable "allow_forwarded_traffic" {
  type = bool
  description = "Controls if forwarded traffic from VMs in the local virtual network is allowed to flow to the remote virtual network"
}

variable "allow_gateway_transit" {
  type = bool
  description = "Controls gatewayLinks can be used in the remote virtual network’s link to the local virtual network"
}

variable "use_remote_gateways" {
  type = bool
  description = "Controls if remote gateways can be used on the local virtual network"
}




