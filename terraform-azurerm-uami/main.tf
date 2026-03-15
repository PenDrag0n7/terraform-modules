#variables
variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "resource_group_name" {
  type = string
}


variable "uami_role_assignments" {
  type = map(
    object({
      scope                 = string #list(string)
      role_definition_name  = string
    })
  )
}


#main.tf
resource "azurerm_user_assigned_identity" "uami" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  tags                = var.tags
}

resource "azurerm_role_assignment" "uami_role_assignments" {
  for_each            = var.uami_role_assignments
  scope                = each.value.scope
  role_definition_name = each.value.role_definition_name
  principal_id         = azurerm_user_assigned_identity.uami.principal_id
}


#output.tf
output "uami" {
  value = azurerm_user_assigned_identity.uami
}

output "uami_role_assignments" {
  value = azurerm_role_assignment.uami_role_assignments
}


#