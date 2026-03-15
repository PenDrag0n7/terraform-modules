variable "name" {
  type        = string
  description = "(Required) Specifies the name of the Application Insights component. Changing this forces a new resource to be created."
}

variable "resource_group_name" {
  type        = string
  description = "(Required) The name of the resource group in which to create the Application Insights component. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "application_type" {
  type        = string
  description = "(Required) Specifies the type of Application Insights to create. Valid values are ios for iOS, java for Java web, MobileCenter for App Center, Node.JS for Node.js, other for General, phone for Windows Phone, store for Windows Store and web for ASP.NET. Please note these values are case sensitive; unmatched values are treated as ASP.NET by Azure. Changing this forces a new resource to be created."
}

variable "daily_data_cap_in_gb" {
  type        = number
  description = "(Optional) Specifies the Application Insights component daily data volume cap in GB."
  default     = null
}

variable "daily_data_cap_notifications_disabled" {
  type        = string
  description = "(Optional) Specifies if a notification email will be send when the daily data volume cap is met."
  default     = null
}

variable "retention_in_days" {
  type        = number
  description = "(Optional) Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Defaults to 90."
  default     = 90
}

variable "sampling_percentage" {
  type        = number
  description = "(Optional) Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry. Defaults to 100."
  default     = 100
}

variable "disable_ip_masking" {
  type        = bool
  description = "(Optional) By default the real client IP is masked as 0.0.0.0 in the logs. Use this argument to disable masking and log the real client IP. Defaults to false."
  default     = false
}


variable "tags" {
  type        = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default     = null
}


variable "workspace_id" {
  type        = string
  description = "(Required) Specifies the id of a log analytics workspace resource. Changing this forces a new resource to be created."
}


variable "local_authentication_disabled" {
  type        = bool
  description = "(Optional) Disable Non-Azure AD based Auth. Defaults to false."
  default     = false
}


variable "internet_ingestion_enabled" {
  type        = bool
  description = "(Optional) Should the Application Insights component support ingestion over the Public Internet? Defaults to true."
  default     = true
}


variable "internet_query_enabled" {
  type        = bool
  description = "(Optional) Should the Application Insights component support querying over the Public Internet? Defaults to true."
  default     = true
}


variable "force_customer_storage_for_profiler" {
  type        = bool
  description = "(Optional) Should the Application Insights component force users to create their own storage account for profiling? Defaults to false."
  default     = false
}
