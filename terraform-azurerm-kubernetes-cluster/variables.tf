variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type        = string
  description = "(Required) Specifies the Resource Group where the Managed Kubernetes Cluster should exist. Changing this forces a new resource to be created."
}

variable "default_node_pool" {
  type = object({
    name                   = string
    vm_size                = string
    enable_host_encryption = bool
    enable_auto_scaling    = bool
    auto_scaling_min       = number
    auto_scaling_default   = number
    auto_scaling_max       = number
    no_scaling_nodecount   = number
    max_pods               = number
    node_labels            = map(string)
    node_taints            = list(string)
    orchestrator_version   = string
    os_disk_size_gb        = number
    os_disk_type           = string
    os_sku                 = string
    vnet_subnet_id         = string
    fips_enabled           = bool
    tags                   = map(string)
    zones                  = list(string)
  })
}

variable "additional_node_pools" {
  type = map(object({
    name                   = string
    vm_size                = string
    enable_host_encryption = bool
    enable_auto_scaling    = bool
    auto_scaling_min       = number
    auto_scaling_default   = number
    auto_scaling_max       = number
    no_scaling_nodecount   = number
    max_pods               = number
    node_labels            = map(string)
    node_taints            = list(string)
    orchestrator_version   = string
    os_disk_size_gb        = number
    os_disk_type           = string
    os_sku                 = string
    vnet_subnet_id         = string
    fips_enabled           = bool
    tags                   = map(string)
    zones                  = list(string)
  }))
}

#NB One of dns_prefix or dns_prefix_private_cluster must be specified
# The dns_prefix must contain between 3 and 45 characters, and can contain only letters, numbers, and hyphens. It must start with a letter and must end with a letter or a number.
variable "dns_prefix" {
  type        = string
  default     = null
  description = "(Optional) DNS prefix specified when creating the managed cluster. Changing this forces a new resource to be created."
}

#variable "dns_prefix_private_cluster" {
#  type        = string
#  default     = null
#}

variable "automatic_channel_upgrade" {
  type    = string
  default = "stable"
  # automatic_channel_upgrade - (Optional) The upgrade channel for this Kubernetes Cluster. 
  # Possible values are patch, rapid, node-image and stable. Omitting this field sets this value to none.
}

variable "api_server_authorized_ip_ranges" {
  type        = list(string)
  default     = []
  description = "(Optional) The IP ranges to whitelist for incoming traffic to the masters."
}


# azure_active_directory_role_based_access_control - (Optional) A azure_active_directory_role_based_access_control block as defined below.
variable "azure_active_directory_role_based_access_control" {
  #type = object({
  #  managed                = bool
  #  tenant_id              = string
  #  admin_group_object_ids = list(string)
  #  azure_rbac_enabled     = bool
  #})
}

variable "aad_rbac_managed" {
  type    = bool
  default = true
}

# monitor_metrics - (Optional) Specifies a Prometheus add-on profile for the Kubernetes Cluster. A monitor_metrics block as defined below.
#An monitor_metrics block supports the following:
#annotations_allowed - (Optional) Specifies a comma-separated list of Kubernetes annotation keys that will be used in the resource's labels metric.
#annotations_allowed - (Optional) Specifies a Comma-separated list of additional Kubernetes label keys that will be used in the resource's labels metric.

variable "azure_policy_enabled" {
  type    = bool
  default = false
}

variable "enable_http_application_routing" {
  type        = bool
  default     = false
  description = "(Optional) Sets whether HTTP Application routing should be enabled. Best practice is false, but this can be enabled for testing if required."
}

# Identity not being set as we always want system assigned

variable "identity_type" {
  type        = string
  default     = "SystemAssigned"
  description = "(Optional) The type of identity used for the managed cluster. The type 'SystemAssigned' is recommended unless you have a specific use case."
}

variable "identity_ids" {
  type        = list(string)
  default     = []
  description = "(Optional) A list of User Assigned Managed Identity IDs to be used for the managed cluster. The type 'SystemAssigned' is recommended unless you have a specific use case."
}

# ingress_application_gateway - (Optional) A ingress_application_gateway block as defined below.

variable "keyvault_secret_rotation_enabled" {
  type    = bool
  default = true
}

variable "keyvault_secret_rotation_interval" {
  type    = string
  default = "10m"
}

variable "kubernetes_version" {
  type        = string
  default     = null
  description = "(Optional) Version of Kubernetes specified when creating the AKS managed cluster. If not specified, the latest recommended version will be used at provisioning time (but won't auto-upgrade)."
}

variable "local_account_disabled" {
  type        = bool
  description = "(Optional) - If true local accounts will be disabled. Defaults to false."
  default     = false
}

variable "maintenance_window_enabled" {
  type    = bool
  default = true
}

variable "maintenance_allowed_windows" {}
# An allowed block exports the following:
#day - (Required) A day in a week. Possible values are Sunday, Monday, Tuesday, Wednesday, Thursday, Friday and Saturday.
#hours - (Required) An array of hour slots in a day. For example, specifying 1 will allow maintenance from 1:00am to 2:00am. Specifying 1, 2 will allow maintenance from 1:00am to 3:00m. Possible values are between 0 and 23.

variable "maintenance_not_allowed_windows" {}
#A not_allowed block exports the following:
#end - (Required) The end of a time span, formatted as an RFC3339 string.
#start - (Required) The start of a time span, formatted as an RFC3339 string.

variable "microsoft_defender" {
  type = object({
    enabled                    = bool
    log_analytics_workspace_id = string
  })
}

variable "network_profile" {
  type = object({
    network_plugin     = string
    network_policy     = string
    service_cidr       = string
    dns_service_ip     = string
    docker_bridge_cidr = string
    outbound_type      = string
  })
}

# node_resource_group - (Optional) The name of the Resource Group where the Kubernetes Nodes should exist. Changing this forces a new resource to be created.
# Note: Azure requires that a new, non-existent Resource Group is used, as otherwise, the provisioning of the Kubernetes Service will fail.

variable "node_resource_group" {
  type = string
}

variable "oms_agent" {
  type = object({
    enabled                    = bool
    log_analytics_workspace_id = string
  })
}

variable "private_cluster_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Should this Kubernetes Cluster have its API server only exposed on internal IP addresses? This provides a Private IP Address for the Kubernetes API on the Virtual Network where the Kubernetes Cluster is located. Defaults to false. Changing this forces a new resource to be created."
}

variable "private_dns_zone_id" {
  type        = string
  default     = null
  description = "(Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, System to have AKS manage this or None. In case of None you will need to bring your own DNS server and set up resolving, otherwise, the cluster will have issues after provisioning. Changing this forces a new resource to be created."
}

variable "public_network_access_enabled" {
  type    = bool
  default = true
}

variable "role_based_access_control_enabled" {
  type    = bool
  default = true
}

variable "sku_tier" {
  type        = string
  default     = "Free"
  description = "(Optional) The SKU Tier that should be used for this Kubernetes Cluster. Possible values are Free and Paid (which includes the Uptime SLA). Defaults to Free."
}

# storage_profile - (Optional) A storage_profile block as defined below.

variable "tags" {
  type    = map(string)
  default = {}
}

# web_app_routing - (Optional) A web_app_routing block as defined below.

# windows_profile - (Optional) A windows_profile block as defined below.

variable "rbac_network_contributor_resource_ids" {
  type = list(string)
  default = []
}

variable "rbac_acr_pull_acr_id" {
  type = string
  default = null
}

#variable "rbac_keyvault_reader_keyvault_id" {
#  type = string
#  default = null
#}

variable "rbac_keyvault_reader_keyvault_ids" {
  type = list(string)
  default = []
}

variable "cluster_wide_rbac" {
  type = map(object({
    group_id = string
    role_name = string
  }))
  default = {}
  description = "A map of groups and roles to assign to the cluster, giving AAD groups specific levels of access cluster-wide."
}

variable "scoped_rbac" {
  type = map(object({
    group_id = string
    role_name = string
    namespace = string
  }))
  default = {}
  description = "A map of groups and roles to assign to specific namespaces, giving AAD groups specific levels of access to the namespace."
}

# For now, don't support subnet CIDR, use an ID instead
variable "agic" {
  type = object({
    gateway_name = string
    subnet_id = string
  })
  default = null
}

variable "oidc_issuer_enabled" {
  type = bool
  description = "(Optional) Enable or Disable the OIDC issuer URL. Required for workload identity."
  default = false
}

variable "workload_identity_enabled" {
  type = bool
  description = "(Optional) Specifies whether Azure AD Workload Identity should be enabled for the Cluster. Defaults to false."
  default = false
}