### Azure Recovery Services Vault ###
resource "azurerm_recovery_services_vault" "vault" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  sku                           = var.sku
  soft_delete_enabled           = var.soft_delete_enabled
  public_network_access_enabled = var.public_network_access_enabled
}
