locals {
    node_pool_node_count = var.enable_auto_scaling == true ? var.auto_scaling_default : var.no_scaling_nodecount
    node_pool_node_min   = var.enable_auto_scaling == true ? var.auto_scaling_min : null
    node_pool_node_max   = var.enable_auto_scaling == true ? var.auto_scaling_max : null
}

resource "azurerm_kubernetes_cluster_node_pool" "nodepool" {
  name                   = var.name
  kubernetes_cluster_id  = var.kubernetes_cluster_id
  vm_size                = var.vm_size
  vnet_subnet_id         = var.vnet_subnet_id
  os_disk_size_gb        = var.os_disk_size_gb
  os_disk_type           = var.os_disk_type
  os_sku                 = var.os_sku
  max_pods               = var.max_pods
  mode                   = var.mode
  node_labels            = var.node_labels
  node_taints            = var.node_taints
  enable_auto_scaling    = var.enable_auto_scaling
  node_count             = local.node_pool_node_count
  min_count              = local.node_pool_node_min
  max_count              = local.node_pool_node_max
  enable_host_encryption = var.enable_host_encryption
  fips_enabled           = var.fips_enabled
  zones                  = var.zones
  orchestrator_version   = var.orchestrator_version
  kubelet_disk_type      = "OS" # No other options for this

  tags = merge({
    managed    = true
    managed_by = "terraform"
  }, var.tags)

  lifecycle {
    ignore_changes = [
      node_count
    ]
  }
}
