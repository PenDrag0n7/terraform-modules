variable "name" {
  type        = string
  description = "(Required) Specifies the name of the resource group."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource group should exist."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the resource group."
}
