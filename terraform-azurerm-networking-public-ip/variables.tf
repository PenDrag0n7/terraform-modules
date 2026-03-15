variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Public IP resource . Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the public ip."
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "sku" {
  description = "(Optional) The SKU of the Public IP. Accepted values are Basic and Standard. Defaults to Basic."
  default     = "Basic"
}

variable "allocation_method" {
  description = "(Required) Defines the allocation method for this IP address. Possible values are Static or Dynamic."
}

variable "domain_name_label" {
  description = "(Optional) Label for the Domain Name. Will be used to make up the FQDN. If a domain name label is specified, an A DNS record is created for the public IP in the Microsoft Azure DNS system."
  default     = null
}

variable "zones" {
  type        = list(string)
  description = "(Optional) A collection containing the availability zone to allocate the Public IP in."
  default     = []
}

variable "ip_tags" {
  type    = map(string)
  description = "(Optional) A mapping of IP tags to assign to the public IP."
  default = {}
}

variable "public_ip_prefix_id" {
  type = string
  description = "(Optional) If specified then public IP address allocated will be provided from the public IP prefix resource. Changing this forces a new resource to be created."
  default = null
}

variable "tags" {
  type    = map(string)
  default = {}
}
