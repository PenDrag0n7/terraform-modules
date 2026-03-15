variable name {
  type = string
  description = "(Required) The name of the MSSQL Database. Changing this forces a new resource to be created."
}

variable server_id {
  type = string
  description = "(Required) The id of the MSSQL Server on which to create the database. Changing this forces a new resource to be created."
}

variable max_size_gb {
  type = number
  description = "(Optional) The max size of the database in gigabytes."
  default = null
}

variable sku_name {
  type = string
  description = "(Optional) Specifies the name of the sku used by the database. Changing this forces a new resource to be created. For example, `GP_S_Gen5_2`,`HS_Gen4_1`,`BC_Gen5_2`, `ElasticPool`, `Basic`, `S0`, `P2`, `DW100c`, `DS100`."
  default = null
}

variable storage_account_type {
  type = string
  default = "Geo"
  description = "(Optional) Specifies the storage account type used to store backups for this database. Changing this forces a new resource to be created. Possible values are `GRS`, `LRS` and `ZRS`. The default value is `GRS`."
}

variable elastic_pool_id {
  type = string
  default = null
  description = "(Optional) Specifies the ID of the elastic pool containing this database."
}

variable "tags" {
  type = map(string)
  description = "(Optional) A mapping of tags to assign to the resource."
  default = {}
}
