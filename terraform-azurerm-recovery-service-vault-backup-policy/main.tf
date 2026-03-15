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

variable "policy_type" {
  type        = string
  description = "The type of the backup policy (FileShareBackup or VMBackup)."
  default     = "VMBackup"
}

variable "frequency" {
  type        = string
  description = "The frequency of the backup policy."
  default     = "Daily"
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
variable "instant_restore_retention_days" {
  type        = number
  description = "The number of days to retain instant restore snapshots."
  default     = 2
}
# variable "instant_restore_retention_days" {
#   type        = number
#   description = "The number of days to retain instant restore snapshots."
#   default     = 2
# }

variable "retention_daily" {
  type        = number
  description = "The number of days to retain daily backups."
  default     = 35
}

variable "retention_weekly" {
  description = "The number of weeks to retain weekly backups."
  type = object({
    count    = number,
    weekdays = list(string)
  })
  default = {
    count    = 90
    weekdays = ["Sunday"]
  }
}

variable "retention_monthly" {
  type        = any
  description = "The number of months to retain monthly backups."
  default     = {}
}

variable "retention_yearly" {
  type        = any
  description = "The number of years to retain yearly backups."
  default     = {}
}

variable "tags" {
  type        = map(any)
  default     = {}
  description = "A mapping of tags to assign to the resource."
}


### Azure Recovery Services Vault ###
resource "azurerm_backup_policy_file_share" "this" {
  for_each            = var.policy_type == "FileShareBackup" ? toset([var.name]) : toset([])
  name                = var.name
  resource_group_name = var.resource_group_name
  recovery_vault_name = var.recovery_vault_name
  timezone            = var.timezone

  backup {
    frequency = var.frequency
    time      = var.time
    # weekdays  = var.frequency == "Weekly" ? var.retention_weekly.weekdays : null
  }

  # Set Daily only if frequency is Daily ##
  dynamic "retention_daily" {
    for_each = var.frequency == "Daily" ? toset([var.retention_daily]) : toset([])
    content {
      count = retention_daily.value
    }
  }

  dynamic "retention_weekly" {
    for_each = try(var.retention_weekly.count, null) != null ? toset([var.retention_weekly]) : toset([])
    content {
      count    = retention_weekly.value.count
      weekdays = retention_weekly.value.weekdays
    }
  }

  dynamic "retention_monthly" {
    for_each = try(var.retention_monthly.count, null) != null ? toset([var.retention_monthly]) : toset([])
    content {
      count    = retention_monthly.value.count
      weekdays = try(retention_monthly.value.weekdays, null)
      weeks    = try(retention_monthly.value.weeks, null)
      days     = try(retention_monthly.value.days, null)
    }
  }

  dynamic "retention_yearly" {
    for_each = try(var.retention_yearly.count, null) != null ? toset([var.retention_yearly]) : toset([])
    content {
      count    = retention_yearly.value.count
      weekdays = try(retention_monthly.value.weekdays, null)
      weeks    = try(retention_monthly.value.weeks, null)
      months   = try(retention_yearly.value.months, null)
      days     = try(retention_monthly.value.days, null)
    }
  }
}


resource "azurerm_backup_policy_vm" "this" {
  for_each                       = var.policy_type == "VMBackup" ? toset([var.name]) : toset([])
  name                           = var.name
  resource_group_name            = var.resource_group_name
  recovery_vault_name            = var.recovery_vault_name
  timezone                       = var.timezone
  instant_restore_retention_days = var.instant_restore_retention_days

  backup {
    frequency = var.frequency
    time      = var.time
    weekdays  = var.frequency == "Weekly" ? var.retention_weekly.weekdays : null
  }

  # Set Daily only if frequency is Daily ##
  dynamic "retention_daily" {
    for_each = var.frequency == "Daily" ? [var.retention_daily] : toset([])
    content {
      count = retention_daily.value
    }
  }

  dynamic "retention_weekly" {
    for_each = try(var.retention_weekly.count, null) != null  ? toset([var.retention_weekly]) : toset([])
    content {
      count    = retention_weekly.value.count
      weekdays = retention_weekly.value.weekdays
    }
  }

  dynamic "retention_monthly" {
    for_each = try(var.retention_monthly.count, null) != null ? toset([var.retention_monthly]) : toset([])
    content {
      count    = retention_monthly.value.count
      weekdays = try(retention_monthly.value.weekdays, null)
      weeks    = try(retention_monthly.value.weeks, null)
      days     = try(retention_monthly.value.days, null)
    }
  }

  dynamic "retention_yearly" {
    for_each = try(var.retention_yearly.count, null) != null ? toset([var.retention_yearly]) : toset([])
    content {
      count    = retention_yearly.value.count
      weekdays = try(retention_monthly.value.weekdays, null)
      weeks    = try(retention_monthly.value.weeks, null)
      months   = try(retention_yearly.value.months, null)
      days     = try(retention_monthly.value.days, null)
    }
  }
}
