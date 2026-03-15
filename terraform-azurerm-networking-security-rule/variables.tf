variable "name" {
  type = string
  description = "(Required) The name of the security rule. This needs to be unique across all Rules in the Network Security Group. Changing this forces a new resource to be created."
}

variable "use_access_name_prefix" {
  type = bool
  description = "(Optional) `True` if Terraform should prepend Allow_ or Deny_ to the name of the rule. Defaults to `false`."
  default = false
}

variable "resource_group_name" {
  type = string
  description = "(Required) The name of the resource group in which to create the Network Security Rule. Changing this forces a new resource to be created."
}

variable "network_security_group_name" {
  type = string
  description = "(Required) The name of the Network Security Group that we want to attach the rule to. Changing this forces a new resource to be created."
}

variable "description" {
  type = string
  description = "(Optional) A description for this rule. Restricted to 140 characters."
  default = ""
}

variable "protocol" {
  type = string
  description = "(Required) Network protocol this rule applies to. Possible values include Tcp, Udp, Icmp, Esp, Ah or * (which matches all)."
}

variable "source_port_range" {
  type = string
  description = "(Optional) Source port or port range."
  default = "*"
}

variable "source_port_ranges" {
  type = list(string)
  description = "(Optional) List of source ports or port ranges."
  default = null
}

variable "destination_port_ranges" {
  type = list(string)
  description = "(Required) List of destination ports or port ranges."
}

variable "source_address_prefix" {
  type = string
  description = "(Optional) CIDR or source IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used."
  default = "*"
}

variable "destination_address_prefix" {
  type = string
  description = "(Optional) CIDR or destination IP range or * to match any IP. Tags such as ‘VirtualNetwork’, ‘AzureLoadBalancer’ and ‘Internet’ can also be used. Besides, it also supports all available Service Tags like ‘Sql.WestEurope‘, ‘Storage.EastUS‘, etc. You can list the available service tags with the cli: shell az network list-service-tags --location westcentralus."
  default = "*"
}

variable "access" {
  type = string
  description = "(Required) Specifies whether network traffic is allowed or denied. Possible values are Allow and Deny."
}

variable "direction" {
  type = string
  description = "(Required) The direction specifies if rule will be evaluated on incoming or outgoing traffic. Possible values are Inbound and Outbound."
}

variable "priority" {
  type = number
  description = "(Required) Specifies the priority of the rule. The value can be between 100 and 4096. The priority number must be unique for each rule in the collection. The lower the priority number, the higher the priority of the rule."
}
