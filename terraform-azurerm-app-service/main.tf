resource "azurerm_app_service" "appService" {
  name                    = var.name
  location                = var.location
  resource_group_name     = var.resource_group_name
  app_service_plan_id     = var.app_service_plan_id

  client_affinity_enabled = var.client_affinity_enabled
  https_only              = var.https_only

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on                 = var.always_on
    linux_fx_version          = var.linux_fx_version
    windows_fx_version        = var.windows_fx_version
    health_check_path         = var.health_check_path    
    ip_restriction            = var.ip_restriction
    scm_ip_restriction        = var.scm_ip_restriction
    use_32_bit_worker_process = var.use_32_bit_worker_process
    scm_use_main_ip_restriction = var.scm_use_main_ip_restriction
  }

  lifecycle {
    ignore_changes = [
      app_settings,
      site_config[0].default_documents,
      site_config[0].dotnet_framework_version,
      site_config[0].php_version
    ]
  }
}
