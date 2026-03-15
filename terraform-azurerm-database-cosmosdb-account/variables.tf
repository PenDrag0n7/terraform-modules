# REQUIRED
variable "name" {
  type        = string
  description = "(Required) Specifies the name of the CosmosDB Account. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which the CosmosDB Account is created. Changing this forces a new resource to be created."
}

# OPTIONAL OR "REQUIRED WITH DEFAULTS"

variable "offer_type" {
  type        = string
  default     = "Standard"
  description = "Specifies the Offer Type to use for this CosmosDB Account - currently this can only be set to Standard. Defaults to Standard."
}

variable "kind" {
  type        = string
  default     = "GlobalDocumentDB"
  description = "(Optional) Specifies the Kind of CosmosDB to create - possible values are GlobalDocumentDB and MongoDB. Defaults to GlobalDocumentDB. Changing this forces a new resource to be created."
}

variable "enable_automatic_failover" {
  type        = bool
  default     = false
  description = "(Optional) Enable automatic fail over for this Cosmos DB account. Defaults to `false`."
}

variable "enable_free_tier" {
  type        = bool
  default     = false
  description = "(Optional) Enable Free Tier pricing option for this Cosmos DB account. Defaults to false. Changing this forces a new resource to be created. Defaults to `false`."
}

variable "enable_multiple_write_locations" {
  type        = bool
  default     = false
  description = "(Optional) Enable multi-master support for this Cosmos DB account. Defaults to `false`."
}

variable "network_acl_bypass_for_azure_services" {
  type        = bool
  default     = false
  description = "(Optional) If azure services can bypass ACLs. Defaults to false."
}

variable "network_acl_bypass_ids" {
  type = list(string)
  default = []
  description = "(Optional) The list of resource Ids for Network Acl Bypass for this Cosmos DB account."
}

# Consistency policy
# Policy defaults to Session as it's a "middle of the road" option that works well for most instances unless another option is explicitly required.

variable "consistency_policy_level" {
  type        = string
  default     = "Session"
  description = "(Required) The Consistency Level to use for this CosmosDB Account - can be either `BoundedStaleness`, `Eventual`, `Session`, `Strong` or `ConsistentPrefix`. Defaults to `Session`."
}

variable "consistency_policy_max_interval" {
  type        = number
  default     = 5
  description = "(Optional) When used with the Bounded Staleness consistency level, this value represents the time amount of staleness (in seconds) tolerated. Accepted range for this value is 5 - 86400 (1 day). Defaults to 5. Required when consistency_level is set to BoundedStaleness."
}

variable "consistency_policy_max_staleness_prefix" {
  type        = number
  default     = 100
  description = "(Optional) When used with the Bounded Staleness consistency level, this value represents the number of stale requests tolerated. Accepted range for this value is 10 – 2147483647. Defaults to 100. Required when consistency_level is set to BoundedStaleness."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Whether or not public network access is allowed for this CosmosDB account."
}

# OPTIONAL

# FIREWALL
variable "ip_range_filter" {
  type        = string
  default     = null
  description = "(Optional) CosmosDB Firewall Support: This value specifies the set of IP addresses or IP address ranges in CIDR form to be included as the allowed list of client IP's for a given database account. IP addresses/ranges must be comma separated and must not contain any spaces."
}

# SUBNET RULES
variable "virtual_network_rules" {
  type = map(object({
    id                                   = string
    ignore_missing_vnet_service_endpoint = bool
  }))
  default     = {}
  description = "(Optional) Configures the virtual network subnets allowed to access this Cosmos DB account"
}

# BACKUP
variable "backup_type" {
  type        = string
  default     = "Periodic"
  description = "(Required) The type of the backup. Possible values are Continuous and Periodic. Defaults to Periodic."
}

variable "backup_interval_in_minutes" {
  type        = number
  default     = 120
  description = "(Optional) The interval in minutes between two backups. This is configurable only when type is Periodic. Possible values are between 60 and 1440. Defaults to 120."
}

variable "backup_retention_in_hours" {
  type        = number
  default     = 24
  description = "(Optional) The time in hours that each backup is retained. This is configurable only when type is Periodic. Possible values are between 8 and 720. Defaults to 24."
}

variable "tags" {
  type = map(string)
  default = {}
  description = "Tags for this CosmosDB Account"
}


# Databases
variable "sqlDatabases" {
  type = map(object({
    name                     = string
    manual_throughput        = number
    autoscale_max_throughput = list(number)

    containers = map(object({
      name                     = string
      partition_key_path       = string
      partition_key_version    = number
      manual_throughput        = number
      autoscale_max_throughput = set(number)
      indexing_mode             = string
      indexing_included_paths   = set(string)
      indexing_excluded_paths   = set(string)
    }))
  }))
  default = {}
}
