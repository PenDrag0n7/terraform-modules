variable "name" {
  type        = string
  description = "(Required) The name of the Windows Virtual Machine. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the Resource Group in which the Windows Virtual Machine should be exist. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) The Azure location where the Windows Virtual Machine should exist. Changing this forces a new resource to be created."
}

variable "size" {
  type        = string
  description = "(Required) The SKU which should be used for this Virtual Machine, such as `Standard_F2`."
}

variable "admin_username" {
  type        = string
  description = "(Required) The username of the local administrator used for the Virtual Machine. Changing this forces a new resource to be created. Defaults to `localadmin`."
  default     = "localadmin"
}

variable "admin_password" {
  type        = string
  description = "(Optional) The Password which should be used for the local-administrator on this Virtual Machine. Leaving this value blank will generate a random password."
  default     = ""
}

variable "vnet_resource_group_name" {
  type        = string
  description = "(Optional) The Resource Group in which the VNET that this machine's NIC should join resides. Only required if the VNET is in a Resource Group other than where the virtual machine is being created."
  default     = ""
}

variable "vnet_name" {
  type        = string
  description = "(Required) The name of the VNET that this machine's NIC will join."
}

variable "subnet_name" {
  type        = string
  description = "(Required) The name of the subnet to which this machine's NIC will be connected"
}

variable "public_ip_allocation_method" {
  type        = string
  description = "(Optional) Defines the allocation method for this machine's public IP address. Possible values are Static or Dynamic. If this VM is not being allocated a public IP address, leave this blank."
  default     = ""
}

variable "public_ip_sku" {
  type    = string
  default = "Basic"
}

variable "public_ip_zones" {
  type    = list(string)
  default = []
}

variable "public_ip_tags" {
  type    = map(string)
  default = {}
}

variable "linked_nsg_id" {
  type        = string
  default     = ""
  description = "(Optional) Specify the ID of a Network Security Group that this VM's NIC should be connected to."
}

variable "os_disk" {
  type = object({
    caching              = string
    storage_account_type = string
  })
  description = "(Required) Specifies the caching and storage account type for this VM's OS disk. Requires both `caching` and `storage_account_type` to be set."
}

variable "source_image_reference" {
  type = object({
    publisher = string
    offer     = string
    sku       = string
    version   = string
  })
  description = "(Required) Specifies the image that this VM should be built from. Requires `publisher`, `offer`, `sku` and `version` to be set."
}

variable "source_image_id"{
  type        = string
  description = "(Optional) Specifies the ID of the image that this VM should be built from. If this is set, the `source_image_reference` variable will be ignored."
  default = null
}


variable "data_disks" {
  type = map(object({
    name                 = string
    storage_account_type = string
    create_option        = string
    disk_size_gb         = string
    lun_number           = number
    tags                 = map(string)
  }))
  default     = {}
  description = "(Optional) Specify a map of data disks to be created an attached to this VM."
}

variable "boot_diagnostics_storage_account_uri" {
  default = null
  description = "(Optional) The URI of a Storage Account where the boot diagnostics should be stored. If this is not set, boot diagnostics will not be enabled."
}

variable "tags" {
  type    = map(string)
  default = {}
}