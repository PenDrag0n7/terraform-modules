variable "name" {
  type = string
  description = "(Required) The name of the Node Pool which should be created within the Kubernetes Cluster. Changing this forces a new resource to be created."
}

variable "kubernetes_cluster_id" {
  type = string
  description = "(Required) The ID of the Kubernetes Cluster where this Node Pool should exist. Changing this forces a new resource to be created."
}

variable "vm_size" {
  type = string
  description = "(Required) The SKU which should be used for the Virtual Machines used in this Node Pool. Changing this forces a new resource to be created."
}

variable "enable_auto_scaling" {
  type = bool
  default = false
  description = "(Optional) Whether to enable auto-scaler. Defaults to `false`."
}

variable "auto_scaling_max" {
  type = number
  default = null
  description = "Required if `enable_auto_scaling` is enabled. The maximum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be greater than or equal to `min_count`."
}

variable "auto_scaling_min" {
  type = number
  default = null
  description = "Required if `enable_auto_scaling` is enabled. (Required) The minimum number of nodes which should exist within this Node Pool. Valid values are between 0 and 1000 and must be less than or equal to `max_count`."
}

variable "auto_scaling_default" {
  type = number
  default = null
  description = "The default value for auto scaling"
}

variable "no_scaling_nodecount" {
  type = number
  default = null
  description = "The number of nodes to provision if `enable_auto_scaling` is disabled."
}

variable "vnet_subnet_id" {
  type = string
  description = "The ID of the subnet in which the node pool will receive IP addresses."
}

variable "os_disk_size_gb" {
  type = number
  description = "(Optional) The Agent Operating System disk size in GB. Changing this forces a new resource to be created."
}

variable "os_disk_type" {
  type = string
  default = "Managed"
  description = "(Optional) The type of disk which should be used for the Operating System. Possible values are Ephemeral and Managed. Defaults to Managed. Changing this forces a new resource to be created."
}

variable "os_sku" {
  type = string
  default = "Linux"
  description = "(Optional) The Operating System which should be used for this Node Pool. Changing this forces a new resource to be created. Possible values are `Linux` and `Windows`. Defaults to `Linux`."
}

variable "max_pods" {
  type = number
  default = 30
  description = "(Optional) The maximum number of pods that can run on each agent, defaults to `30`. Changing this forces a new resource to be created."
}

variable "mode" {
  type = string
  default = "User"
  description = "(Optional) Should this Node Pool be used for System or User resources? Possible values are `System` and `User`. Defaults to `User`."
}

variable "orchestrator_version" {
  type = string
  default     = null
  description = "(Optional) The version of kubernetes to deploy onto this node pool. If not specified, the version matching the cluster version will be deployed."
}

variable "enable_host_encryption" {
  type = bool
  default = false
  description = "(Optional) Should the nodes in this Node Pool have host encryption enabled? Defaults to `false`."
}

variable "fips_enabled" {
  type = bool
  default = false
  description = "(Optional) Should the nodes in this Node Pool have Federal Information Processing Standard enabled? Changing this forces a new resource to be created."
}

variable "zones" {
  type = list(string)
  default = []
  description = "(Optional) A list of Availability Zones where the Nodes in this Node Pool should be created in. Changing this forces a new resource to be created."
}

variable "node_labels" {
  type = map(string)
  default = {}
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in this Node Pool. Changing this forces a new resource to be created."
}

variable "node_taints" {
  type = list(string)
  default = []
  description = "(Optional) A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created."
}

variable "tags" {
  type = map(string)
  default = {}
  description = "(Optional) A mapping of tags to assign to the resource."
}
