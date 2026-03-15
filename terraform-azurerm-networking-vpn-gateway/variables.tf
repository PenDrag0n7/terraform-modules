variable "name" {
  type        = string
  description = "(Required) The name of the Virtual Network Gateway. Changing the name forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Virtual Network Gateway. Changing the resource group name forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) The location/region where the Virtual Network Gateway is located. Changing the location/region forces a new resource to be created."
}

variable "sku" {
  type        = string
  description = "(Required) Configuration of the size and capacity of the virtual network gateway. Valid options are Basic, Standard, HighPerformance, UltraPerformance, ErGw1AZ, ErGw2AZ, ErGw3AZ, VpnGw1, VpnGw2, VpnGw3, VpnGw4,VpnGw5, VpnGw1AZ, VpnGw2AZ, VpnGw3AZ,VpnGw4AZ and VpnGw5AZ and depend on the type, vpn_type and generation arguments. A PolicyBased gateway only supports the Basic sku. Further, the UltraPerformance sku is only supported by an ExpressRoute gateway."
}

variable "type" {
  type        = string
  description = "(Required) The type of the Virtual Network Gateway. Valid options are Vpn or ExpressRoute. Changing the type forces a new resource to be created."
}

variable "vpn_type" {
  type        = string
  description = "(Optional) The routing type of the Virtual Network Gateway. Valid options are RouteBased or PolicyBased. Defaults to RouteBased."
  default     = "RouteBased"
}

variable "active_active" {
  type        = bool
  description = "(Optional) Is Active Active feature enabled for this Virtual Network Gateway? Defaults to false."
  default     = false
}

variable "public_ip_id" {
  type        = string
  description = "(Required) The ID of the Public IP address for this Virtual Network Gateway."
}

variable "subnet_id" {
  type        = string
  description = "(Required) The ID of the subnet for this Virtual Network Gateway."
}

variable "enable_bgp" {
  type        = bool
  description = "(Optional) Should BGP (Border Gateway Protocol) be enabled for this Virtual Network Gateway? Defaults to false."
  default     = false
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "vpn_client_configuration" {
  type = object({
    aad_audience         = string
    aad_issuer           = string
    aad_tenant           = string
    address_space        = list(string)
    vpn_auth_types       = list(string)
    vpn_client_protocols = list(string)
  })
  description = "In this block the Virtual Network Gateway can be configured to accept IPSec point-to-site connections."
}
