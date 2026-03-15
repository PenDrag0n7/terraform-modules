#resource "azurerm_firewall_policy" "default_policy" {
#  name                = "fwp-default-${var.name}"
#  location            = var.location
#  resource_group_name = var.resource_group_name
#}

resource "azurerm_firewall" "fw" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = var.sku_name   #"AZFW_VNet"
  sku_tier            = var.sku_tier #"Standard"
  threat_intel_mode   = var.threat_intel_mode
  zones               = var.zones
  #firewall_policy_id  = azurerm_firewall_policy.default_policy.id

  tags = merge({
    managed    = true
    managed_by = "terraform"
  }, var.tags)

  management_ip_configuration {
    name                 = var.management_ip_configuration.name
    subnet_id            = var.management_ip_configuration.subnet_id
    public_ip_address_id = var.management_ip_configuration.public_ip_address_id
  }

  dynamic "ip_configuration" {
    for_each = var.public_ip_ids
    iterator = each
    content {
      name                 = each.value.name
      subnet_id            = each.value.subnet_id
      public_ip_address_id = each.value.public_ip_address_id
    }    
  }
}
