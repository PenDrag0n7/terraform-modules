variable "name" {
  type        = string
  description = "(Required) Specifies the name of the storage account. Only lowercase Alphanumeric characters allowed. Changing this forces a new resource to be created. This must be unique across the entire Azure service, not just within the resource group."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the storage account. Changing this forces a new resource to be created."
}

variable "location" {
  type = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "account_kind" {
  type = string
  description = "(Optional) Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2. Defaults to StorageV2."
  default = "StorageV2"
}

variable "account_tier" {
  type = string
  description = "(Required) Defines the Tier to use for this storage account. Valid options are Standard and Premium. For BlockBlobStorage and FileStorage accounts only Premium is valid. Changing this forces a new resource to be created."
}

variable "account_replication_type" {
  type = string
  description = "(Required) Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
}

variable "cross_tenant_replication_enabled" {
  type = bool
  description = "(Optional) Should cross Tenant replication be enabled? Defaults to true."
  default = true
}

variable "access_tier" {
  type = string
  description = "(Optional) Defines the access tier for BlobStorage, FileStorage and StorageV2 accounts. Valid options are Hot and Cool, defaults to Hot."
  default = "Hot"
}

variable "enable_https_traffic_only" {
  type = bool
  description = "(Optional) Boolean flag which forces HTTPS if enabled, see here for more information. Defaults to true."
  default = true
}

variable "min_tls_version" {
  type = string
  description = "(Optional) The minimum supported TLS version for the storage account. Possible values are TLS1_0, TLS1_1, and TLS1_2. Defaults to TLS1_2 for new storage accounts."
  default = "TLS1_2"
}

variable "public_network_access_enabled" {
  type = bool
  description = "(Optional) Whether the public network access is enabled? Defaults to false."
  default = false
}

variable "is_hns_enabled" {
  type = bool
  description = "(Optional) Is Hierarchical Namespace enabled? This can be used with Azure Data Lake Storage Gen 2 (see here for more information). Changing this forces a new resource to be created. Defaults to false."
  default = false
  # This can only be true when account_tier is Standard or when account_tier is Premium and account_kind is BlockBlobStorage
}

variable "network_rules" {
  type = object({
    default_action = string
    bypass = list(string)
    ip_rules = list(string)
    virtual_network_subnet_ids = list(string)
  })
  description = "(Optional) A network_rules block"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags for this resource"
}

variable "containers" {
  type = map(object({
    name = string
    container_access_type = string
  }))
}