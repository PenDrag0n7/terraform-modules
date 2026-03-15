output "cluster" {
  value = azurerm_kubernetes_cluster.cluster
  sensitive = true
}