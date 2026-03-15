variable "name" {
  type        = string
  description = "(Required) The name of the Private DNS Zone. Must be a valid domain name."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Specifies the resource group where the resource exists. Changing this forces a new resource to be created."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags for this resource"
}