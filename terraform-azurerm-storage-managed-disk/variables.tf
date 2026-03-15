variable "name" {
  type = string
  description = "(Required) Specifies the name of the Managed Disk. Changing this forces a new resource to be created."  
}

variable "resource_group_name" {
  type = string
  description = "(Required) The name of the Resource Group where the Managed Disk should exist."
}

variable "location" {
  type = string
  description = "(Required) Specified the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "storage_account_type" {
  type = string
  description = "(Required) The type of storage to use for the managed disk. Possible values are `Standard_LRS`, `Premium_LRS`, `StandardSSD_LRS` or `UltraSSD_LRS`."
}

variable "create_option" {
  type = string
  description = "(Required) The method to use when creating the managed disk. Changing this forces a new resource to be created."
}

variable "disk_size_gb" {
  type = number
  description = "(Optional, Required for a new managed disk) Specifies the size of the managed disk to create in gigabytes. If `create_option` is `Copy` or `FromImage`, then the value must be equal to or greater than the source's size. The size can only be increased."
}

variable tags {
  type = map(string)
  description = ""
}
