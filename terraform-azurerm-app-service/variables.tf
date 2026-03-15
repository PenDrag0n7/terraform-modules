# Required
variable "name" {
  type = string
  description = "Specifies the name of the App Service. Changing this forces a new resource to be created."
}

variable "location" {
  type = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type = string
  description = "The name of the resource group in which to create the App Service."
}

variable "app_service_plan_id" {
  type = string
  description = "The ID of the App Service Plan within which to create this App Service."
}

# Optional
variable "client_affinity_enabled" {
  type    = bool
  default = false
  description = "(Optional) Should the App Service send session affinity cookies, which route client requests in the same session to the same instance?"
}

variable "https_only" {
  type    = bool
  default = false
  description = "(Optional) Can the App Service only be accessed via HTTPS? Defaults to false."
}

variable "app_settings" {
  type = map(string)
  default = null
  description = "(Optional) A key-value pair of App Settings."
}

# SITE CONFIG NESTED
variable "linux_fx_version" {
  type = string
  default = null
  description = "(Optional) The Linux Docker container image (DOCKER|<user/image:tag>)"
}

variable "windows_fx_version" {
  type = string
  default = null
  description = "(Optional) The Windows Docker container image (DOCKER|<user/image:tag>)"
}

variable "always_on" {
  type    = bool
  default = true
  description = "(Optional) Should the app be loaded at all times? Defaults to false."
}

variable "health_check_path" {
  type    = string
  default = ""
  description = "(Optional) The health check path to be pinged by App Service."
}

variable "ip_restriction" {
  type = list(
    object({
      action                    = string
      ip_address                = string
      name                      = string
      priority                  = number
      service_tag               = string
      #subnet_id                 = string
      virtual_network_subnet_id = string
      headers = list(object({
        x_azure_fdid = list(string)
        x_fd_health_probe = set(string)
        x_forwarded_for = list(string)
        x_forwarded_host = list(string)
      }))
    })
  )
  default = []
  description = "(Optional) A List of objects representing ip restrictions."
}

variable "scm_use_main_ip_restriction" {
    type = bool
    default = true
}

variable "scm_ip_restriction" {
  type = list(
    object({
      action                    = string
      ip_address                = string
      name                      = string
      priority                  = number
      service_tag               = string
      subnet_id                 = string
      virtual_network_subnet_id = string
      headers = list(object({
        x_azure_fdid = list(string)
        x_fd_health_probe = set(string)
        x_forwarded_for = list(string)
        x_forwarded_host = list(string)
      }))
    })
  )
  default = []
  description = "(Optional) A List of objects representing ip restrictions."
}

variable "storage_accounts" {
  type = map(
    object({
      name         = string
      type         = string
      account_name = string
      share_name   = string
      access_key   = string
      mount_path   = string
    })
  )
  default = {}
  description = "(Optional) One or more storage_account blocks."
}

# RELATED TO OTHER MODULES
variable "app_insights_workspace_id" {
  type = string
  default = null
  description = "(Optional) The ID of the log analytics workspace to connect the app insights resource to. Defaults to `null`."
}

variable "use_32_bit_worker_process" {
  type = bool
  default = false
  description = "(Optional) Should the App Service run in 32 bit mode, rather than 64 bit mode? Defaults to `false`"
}
