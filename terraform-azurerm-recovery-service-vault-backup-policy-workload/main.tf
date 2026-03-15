### Variables ###
variable "recovery_vault_name" {
  type        = string
  description = "The name of the Recovery Services Vault."
}

variable "resource_group_name" {
  type        = string
  description = "value of the resource group name"
}

variable "name" {
  type        = string
  description = "The name of the backup policy."
}

variable "timezone" {
  type        = string
  description = "The timezone of the backup policy."
  default     = "UTC"
}

variable "time" {
  type        = string
  description = "The time of the backup policy."
  default     = "12:00"
}

#### validate  1 and 5. if frequency is weekly then 5 ####
variable "workload_type" {
  type        = string
  description = "The number of days to retain instant restore snapshots."
  default     = "SQLDataBase"
}

variable "compression_enabled" {
  type        = bool
  description = "The number of days to retain instant restore snapshots."
  default     = true
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "A mapping of tags to assign to the resource."
}

variable "protection_policy" {
  type    = any
  default = {}
}

locals {
  policy = {
    for k, v in var.protection_policy : k => {
      policy_type = v.policy_type
      backup = {
        frequency_in_minutes = try(v.frequency_in_minutes, null)
        frequency            = try(v.frequency, null)
        time                 = try(v.time, null)
        weekdays             = try(v.frequency, null) == "Weekly" ? try(v.retention_weekly.weekdays, null) : null
      }
      simple_retention  = try(v.simple_retention, null) != null ? [v.simple_retention] : []
      retention_daily   = try(v.frequency, null) == "Daily" ? [try(v.retention_daily, null)] : []
      retention_weekly  = try(v.retention_weekly, null) != null ? [v.retention_weekly] : []
      retention_monthly = try(v.retention_monthly.count, null) != null ? [v.retention_monthly] : []
    }
  }

}


resource "azurerm_backup_policy_vm_workload" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_vault_name
  workload_type       = var.workload_type

  settings {
    time_zone           = var.timezone
    compression_enabled = var.compression_enabled
  }

  dynamic "protection_policy" {
    for_each = { for k, v in var.protection_policy : k => local.policy[k] }
    iterator = pp

    content {
      policy_type = pp.value.policy_type

      backup {
        frequency_in_minutes = pp.value.backup.frequency_in_minutes
        frequency            = pp.value.backup.frequency
        time                 = pp.value.backup.time
        weekdays             = pp.value.backup.weekdays
      }

      dynamic "simple_retention" {
        for_each = pp.value.simple_retention
        content {
          count = simple_retention.value
        }
      }

      dynamic "retention_daily" {
        for_each = pp.value.retention_daily
        content {
          count = retention_daily.value
        }
      }

      dynamic "retention_weekly" {
        for_each = pp.value.retention_weekly
        content {
          count    = retention_weekly.value.count
          weekdays = retention_weekly.value.weekdays
        }
      }

      dynamic "retention_monthly" {
        for_each = pp.value.retention_monthly
        content {
          count       = retention_monthly.value.count
          format_type = retention_monthly.value.format_type
          weekdays    = retention_monthly.value.weekdays
          weeks       = retention_monthly.value.weeks
          monthdays   = retention_monthly.value.monthdays
        }
      }
      
    }
  }
}

output "local_policy" {
  value = local.policy
}
