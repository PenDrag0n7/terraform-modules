data "azurerm_kubernetes_cluster" "cluster" {
  name                = var.cluster_name
  resource_group_name = var.cluster_resource_group_name
}

# Reader and Secrets User RBAC
resource "azurerm_role_assignment" "rbac_keyvault_reader" {
 scope                = var.keyvault_id
 role_definition_name = "Key Vault Reader"
 principal_id         = data.azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
}

resource "azurerm_role_assignment" "rbac_keyvault_secrets_user" {
 scope                = var.keyvault_id
 role_definition_name = "Key Vault Secrets User"
 principal_id         = data.azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
}
