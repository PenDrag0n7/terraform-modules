variable "name" {
  type = string
  description = "(Required) Specifies the name of the Log Analytics Workspace. Workspace name should include 4-63 letters, digits or '-'. The '-' shouldn't be the first or the last symbol. Changing this forces a new resource to be created."
}

variable "location" {
  type = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type = string
  description = "(Required) The name of the resource group in which the Log Analytics workspace is created. Changing this forces a new resource to be created."
}

variable "sku" {
  type = string
  default = "PerGB2018"
  description = "(Optional) Specifies the Sku of the Log Analytics Workspace. As of 2018-04-03, the only valid value for this is `PerGB2018`."
}

variable "retention_in_days" {
  type = number
  default = 30
  description = " (Optional) The workspace data retention in days. Possible values between `30` and `730`."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "(Optional) A mapping of tags to assign to the log analytics workspace."
}
