locals {
  keyvault_config = var.keyvault_secret_rotation_enabled == null ? {} : {
    keyvault = {
      rotation_interval = var.keyvault_secret_rotation_interval
    }
  }

  agic_config = var.agic == null ? {} : {
    agic = {
      gateway_name = var.agic.gateway_name
      subnet_id = var.agic.subnet_id
    }
  }

  aad_rbac_config = var.aad_rbac_managed == true ? var.azure_active_directory_role_based_access_control : {
    config = {
      managed                = false
      tenant_id              = null
      admin_group_object_ids = []
      azure_rbac_enabled     = false
    }
  }

  default_node_pool_node_count = var.default_node_pool.enable_auto_scaling == true ? var.default_node_pool.auto_scaling_default : var.default_node_pool.no_scaling_nodecount
  default_node_pool_node_min   = var.default_node_pool.enable_auto_scaling == true ? var.default_node_pool.auto_scaling_min : null
  default_node_pool_node_max   = var.default_node_pool.enable_auto_scaling == true ? var.default_node_pool.auto_scaling_max : null

  maintenance_windows = var.maintenance_window_enabled == true ? var.maintenance_allowed_windows : {}

  defender_config = var.microsoft_defender.enabled == false ? {} : {
    defender = {
      log_analytics_workspace_id = var.microsoft_defender.log_analytics_workspace_id
    }
  }
  oms_config = var.oms_agent.enabled == false ? {} : {
    oms_agent = {
      log_analytics_workspace_id = var.oms_agent.log_analytics_workspace_id
    }
  }
}


resource "azurerm_kubernetes_cluster" "cluster" {
  name                              = var.name
  location                          = var.location
  resource_group_name               = var.resource_group_name
  dns_prefix                        = var.dns_prefix
  api_server_authorized_ip_ranges   = var.api_server_authorized_ip_ranges
  kubernetes_version                = var.kubernetes_version
  automatic_channel_upgrade         = var.automatic_channel_upgrade
  sku_tier                          = var.sku_tier
  public_network_access_enabled     = var.public_network_access_enabled
  azure_policy_enabled              = var.azure_policy_enabled
  role_based_access_control_enabled = var.role_based_access_control_enabled
  node_resource_group               = var.node_resource_group
  oidc_issuer_enabled               = var.oidc_issuer_enabled
  workload_identity_enabled         = var.workload_identity_enabled
  
  # Private cluster
  private_cluster_enabled = var.private_cluster_enabled
  private_dns_zone_id     = var.private_dns_zone_id

  local_account_disabled           = var.local_account_disabled
  http_application_routing_enabled = var.enable_http_application_routing

  lifecycle {
    ignore_changes = [
      default_node_pool[0].node_count,
      tags
    ]
  }

#If private_dns_zone_id is not null or empty use UserAssigned else SystemAssigned
identity {
    type = var.identity_type
    identity_ids = var.identity_type == "UserAssigned" ? var.identity_ids : []
}
# identity {
#   type = "SystemAssigned"
# }

  #Keyvault provider - if configured
  dynamic "key_vault_secrets_provider" {
    for_each = local.keyvault_config
    iterator = each

    content {
      secret_rotation_enabled  = true
      secret_rotation_interval = each.value.rotation_interval
    }
  }

  # AAD RBAC
  dynamic "azure_active_directory_role_based_access_control" {
    for_each = local.aad_rbac_config
    iterator = each

    content {
      managed                = each.value.managed
      tenant_id              = each.value.tenant_id
      admin_group_object_ids = each.value.admin_group_object_ids
      azure_rbac_enabled     = each.value.azure_rbac_enabled
    }
  }

  dynamic "maintenance_window" {
    for_each = local.maintenance_windows
    iterator = each

    content {
      allowed {
        day = each.value.day
        hours = each.value.hours
      }
    }
  }

  dynamic "microsoft_defender" {
    for_each = local.defender_config
    iterator = each

    content {
      log_analytics_workspace_id = each.value.log_analytics_workspace_id
    }
  }

  dynamic "oms_agent" {
    for_each = local.oms_config
    iterator = each

    content {
      log_analytics_workspace_id = each.value.log_analytics_workspace_id
    }
  }

  network_profile {
    network_plugin     = var.network_profile.network_plugin
    network_policy     = var.network_profile.network_policy
    service_cidr       = var.network_profile.service_cidr
    dns_service_ip     = var.network_profile.dns_service_ip
    docker_bridge_cidr = var.network_profile.docker_bridge_cidr
    outbound_type      = var.network_profile.outbound_type
  }

  default_node_pool {
    name                   = var.default_node_pool.name
    vm_size                = var.default_node_pool.vm_size
    enable_host_encryption = var.default_node_pool.enable_host_encryption
    enable_auto_scaling    = var.default_node_pool.enable_auto_scaling
    node_count             = local.default_node_pool_node_count
    min_count              = local.default_node_pool_node_min
    max_count              = local.default_node_pool_node_max
    max_pods               = var.default_node_pool.max_pods
    node_labels            = var.default_node_pool.node_labels
    node_taints            = var.default_node_pool.node_taints
    orchestrator_version   = var.default_node_pool.orchestrator_version
    os_disk_size_gb        = var.default_node_pool.os_disk_size_gb
    os_disk_type           = var.default_node_pool.os_disk_type
    os_sku                 = var.default_node_pool.os_sku
    vnet_subnet_id         = var.default_node_pool.vnet_subnet_id
    fips_enabled           = var.default_node_pool.fips_enabled
    tags                   = var.default_node_pool.tags
    zones                  = var.default_node_pool.zones
  }

  # AGIC, if enabled
  dynamic "ingress_application_gateway" {
    for_each = local.agic_config
    iterator = each

    content {
      gateway_name = each.value.gateway_name
      subnet_id = each.value.subnet_id
    }
  }

  tags = merge({
    managed    = true
    managed_by = "terraform",
    deployment_date = formatdate("YYYY-MM-DD", timestamp())
  }, var.tags)
}

# The cluster needs Network Contributor on the virtual network, as well as potentially on other resources

# resource "azurerm_role_assignment" "rbac_network_contributor" {
#   count = var.rbac_network_contributor_vnet_id != null ? 1 : 0
#   scope                = var.rbac_network_contributor_vnet_id
#   role_definition_name = "Network Contributor"
#   principal_id         = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
# }

resource "azurerm_role_assignment" "rbac_network_contributor" {
  for_each             = toset(var.rbac_network_contributor_resource_ids)
  scope                = each.value
  role_definition_name = "Network Contributor"
  # principal_id         = azurerm_kubernetes_cluster.cluster.identity[0].principal_id
  principal_id         = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
}


# Give the cluster permission to pull images
resource "azurerm_role_assignment" "rbac_acr_pull" {
  count = var.rbac_acr_pull_acr_id != null ? 1 : 0
  scope                = var.rbac_acr_pull_acr_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
}

# Reader and Secrets User RBAC
resource "azurerm_role_assignment" "rbac_keyvault_reader" {
 count                = length(var.rbac_keyvault_reader_keyvault_ids)
 scope                = var.rbac_keyvault_reader_keyvault_ids[count.index]
 role_definition_name = "Key Vault Reader"
 principal_id         = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
}
resource "azurerm_role_assignment" "rbac_keyvault_secrets_user" {
 count                = length(var.rbac_keyvault_reader_keyvault_ids)
 scope                = var.rbac_keyvault_reader_keyvault_ids[count.index]
 role_definition_name = "Key Vault Secrets User"
 principal_id         = azurerm_kubernetes_cluster.cluster.kubelet_identity[0].object_id
}

# Cluster-wide RBAC
resource "azurerm_role_assignment" "cluster_wide_rbac" {
 for_each             = var.cluster_wide_rbac
 scope                = azurerm_kubernetes_cluster.cluster.id
 role_definition_name = each.value.role_name
 principal_id         = each.value.group_id
}

# Scoped RBAC
resource "azurerm_role_assignment" "scoped_rbac" {
 for_each             = var.scoped_rbac
 scope                = "${azurerm_kubernetes_cluster.cluster.id}/namespaces/${each.value.namespace}"
 role_definition_name = each.value.role_name
 principal_id         = each.value.group_id
}


module "nodePool" {
  #source   = "app.terraform.io/bluehalo/resource-group/azurerm"
  #version  = "1.0.1"
  source                                           = "../terraform-azurerm-kubernetes-node-pool"
  for_each                                         = var.additional_node_pools
  name                                             = each.value.name
  kubernetes_cluster_id                            = azurerm_kubernetes_cluster.cluster.id
 #automatic_channel_upgrade                        = each.value.automatic_channel_upgrade
  vm_size                = each.value.vm_size
  enable_host_encryption = each.value.enable_host_encryption
  enable_auto_scaling    = each.value.enable_auto_scaling
  auto_scaling_default   = each.value.auto_scaling_default
  auto_scaling_min       = each.value.auto_scaling_min
  auto_scaling_max       = each.value.auto_scaling_max
  no_scaling_nodecount   = each.value.no_scaling_nodecount
  max_pods               = each.value.max_pods
  node_labels            = each.value.node_labels
  node_taints            = each.value.node_taints
  orchestrator_version   = each.value.orchestrator_version
  os_disk_size_gb        = each.value.os_disk_size_gb
  os_disk_type           = each.value.os_disk_type
  os_sku                 = each.value.os_sku
  vnet_subnet_id         = each.value.vnet_subnet_id
  fips_enabled           = each.value.fips_enabled
  tags                   = each.value.tags
  zones                  = each.value.zones
}