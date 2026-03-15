# variable "public_ip" {
#   type = object({
#     public_ip_name      = optional(string, null)
#     create_public_ip    = optional(bool, false)
#     sku                 = optional(string, "Basic")
#     allocation_method   = optional(string, "Dynamic")
#     resource_group_name = optional(string, null)
#     location            = optional(string, null)
#     zones               = optional(list(number), [])
#   })
#   # default     = {}
#   description = "Public IP for VPN Gateway"
# }

# module "pip" {
#   source              = "../terraform-azurerm-networking-public-ip"
#   for_each            = { for v in toset([var.public_ip]) : v.public_ip_name => v if try(v.create_public_ip, null) }
#   name                = each.value.public_ip_name
#   resource_group_name = coalesce(each.value.resource_group_name, var.resource_group_name)
#   location            = coalesce(each.value.location, var.location)
#   sku                 = var.type == "ExpressRoute" ? "Standard" : try(each.value.sku, "Basic")
#   allocation_method   = var.type == "ExpressRoute" ? "Static" : try(each.value.allocation_method, "Dynamic")
#   zones               = each.value.zones
# }

# data "azurerm_public_ip" "this" {
#   for_each = { for v in toset([var.public_ip]) : v.public_ip_name => v
#     if(!try(v.create_public_ip, false) && try(v.public_ip_name, null) != null)
#   }

#   name                = each.value.public_ip_name
#   resource_group_name = coalesce(each.value.resource_group_name, var.resource_group_name)
# }

resource "azurerm_virtual_network_gateway" "vpnGw" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name
  type                = var.type
  vpn_type            = var.vpn_type
  active_active       = var.active_active
  enable_bgp          = var.enable_bgp
  sku                 = var.sku

  ip_configuration {
    name                          = "default"
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = var.public_ip_id #try(module.pip[var.public_ip.public_ip_name].ip.id, var.public_ip_id, null)
    subnet_id                     = var.subnet_id
  }

  dynamic "vpn_client_configuration" {
    for_each = try(var.vpn_client_configuration) != null ? [var.vpn_client_configuration] : []
    content {
      address_space        = vpn_client_configuration.value.address_space
      aad_issuer           = vpn_client_configuration.value.aad_issuer
      aad_audience         = vpn_client_configuration.value.aad_audience
      aad_tenant           = vpn_client_configuration.value.aad_tenant
      vpn_auth_types       = vpn_client_configuration.value.vpn_auth_types
      vpn_client_protocols = vpn_client_configuration.value.vpn_client_protocols
    }
  }

  tags = var.tags
}
