variable "custom_network_interface_name" {
  type        = string
  description = "The name of the custom network interface."
  default     = null

}

resource "azurerm_private_endpoint" "private_endpoint" {
  name                          = var.name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  subnet_id                     = var.subnet_id #coalesce(var.subnet_id, data.azurerm_subnet.sn.id)
  custom_network_interface_name = try(var.custom_network_interface_name, null)

  private_service_connection {
    name                           = var.private_connection_name
    private_connection_resource_id = var.private_connection_resource_id
    is_manual_connection           = var.is_manual_connection
    subresource_names              = var.subresource_names
  }
  dynamic "private_dns_zone_group" {
    for_each = try(var.private_dns_zone_ids, null) != null ? [1] : []
    content {
      name                 = "default"
      private_dns_zone_ids = var.private_dns_zone_ids
    }
  }
}
