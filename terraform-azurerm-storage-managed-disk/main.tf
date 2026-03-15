resource "azurerm_managed_disk" "disk" {
  name                  = var.name
  resource_group_name   = var.resource_group_name
  location              = var.location
  storage_account_type  = var.storage_account_type
  create_option         = var.create_option
  disk_size_gb          = var.disk_size_gb
  
  tags = merge(var.tags, {
    managed       = true
    managed_by    = "terraform"
  })
}
