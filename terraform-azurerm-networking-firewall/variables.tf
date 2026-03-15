variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Firewall. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the resource. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "sku_name" {
  type        = string
  description = "(Required) SKU name of the Firewall. Possible values are AZFW_Hub and AZFW_VNet. Changing this forces a new resource to be created."
}

variable "sku_tier" {
  type        = string
  description = "(Required) SKU tier of the Firewall. Possible values are Premium, Standard and Basic."
}

variable "management_ip_configuration" {
  type = object({
    name = string
    subnet_id = string
    public_ip_address_id = string
  })
  description = "(Optional) A management_ip_configuration block, which allows force-tunnelling of traffic to be performed by the firewall. Adding or removing this block or changing the subnet_id in an existing block forces a new resource to be created. Changing this forces a new resource to be created."
}

# variable "management_ip_name" {
#   type = string
# }

# variable "management_ip_subnet_id" {
#   type = string
# }

# variable "management_ip_address_id" {
#   type = string
# }

variable "public_ip_ids" {
  type = map(object({
    name = string
    subnet_id = string
    public_ip_address_id = string
  }))
}

#variable "ip_configuration" {
#  type = object({
#    name = string
#    public_ip_address_id = string
#  })
#  description = "(Optional) A ip_configuration block, which allows force-tunnelling of traffic to be performed by the firewall. Adding or removing this block or changing the subnet_id in an existing block forces a new resource to be created. Changing this forces a new resource to be created."
#}

variable "threat_intel_mode" {
  description = "(Optional) The operation mode for threat intelligence-based filtering. Possible values are: Off, Alert and Deny. Defaults to Alert."
  default     = "Alert"
  type        = string
}

variable "zones" {
  type        = list(string)
  description = " (Optional) Specifies a list of Availability Zones in which this Azure Firewall should be located. Changing this forces a new Azure Firewall to be created."
  default     = []
}

variable "tags" {
  type    = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default = {}
}
