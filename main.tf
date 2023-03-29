resource "azurerm_application_insights" "this" {
  count               = var.enable_appinsights ? 1 : 0
  name                = "lapp-${var.project}-${var.env}-${var.location}-${var.name}"
  location            = var.location
  resource_group_name = var.resource_group
  application_type    = var.application_type
  workspace_id        = var.analytics_workspace_id
  tags                = var.tags
}

data "azurerm_monitor_diagnostic_categories" "this" {
  count       = var.analytics_workspace_id == null ? 0 : 1
  resource_id = azurerm_logic_app_standard.this.id
}

resource "azurerm_monitor_diagnostic_setting" "this" {
  count                          = var.analytics_workspace_id == null ? 0 : 1
  name                           = "lapp-${var.project}-${var.env}-${var.location}-${var.name}"
  target_resource_id             = azurerm_logic_app_standard.this.id
  log_analytics_workspace_id     = var.analytics_workspace_id
  log_analytics_destination_type = var.analytics_destination_type

  dynamic "enabled_log" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[0].log_category_types
    content {
      category = enabled_log.value
    }
  }

  dynamic "metric" {
    for_each = data.azurerm_monitor_diagnostic_categories.this[0].metrics
    content {
      category = metric.value
    }
  }
  lifecycle {
    ignore_changes = [log_analytics_destination_type] # TODO remove when issue is fixed: https://github.com/Azure/azure-rest-api-specs/issues/9281
  }
}

locals {
  app_settings = {
    WEBSITE_USE_PLACEHOLDER               = var.use_placeholder
    AZURE_LOG_LEVEL                       = var.log_level
    AzureWebJobsDisableHomepage           = var.disable_homepage
    APPLICATIONINSIGHTS_CONNECTION_STRING = var.enable_appinsights ? azurerm_application_insights.this[0].connection_string : null
    APPINSIGHTS_INSTRUMENTATIONKEY        = var.enable_appinsights ? azurerm_application_insights.this[0].instrumentation_key : null
    AzureFunctionsWebHost__hostid         = substr("lapp-${var.project}-${var.env}-${var.location}-${var.name}", -32, -1)
    FUNCTIONS_WORKER_RUNTIME              = var.runtime_version == "~4" ? var.worker_runtime : null
    WEBSITE_NODE_DEFAULT_VERSION          = var.runtime_version == "~4" ? var.node_version : null
  }
}

resource "azurerm_logic_app_standard" "this" {
  name                 = "lapp-${var.project}-${var.env}-${var.location}-${var.name}"
  resource_group_name  = var.resource_group
  location             = var.location
  app_service_plan_id  = var.service_plan_id
  app_settings         = merge(local.app_settings, var.app_settings)
  use_extension_bundle = var.use_extension_bundle
  bundle_version       = var.use_extension_bundle ? var.bundle_version : null
  enabled              = var.enabled
  https_only           = var.https_only
  identity {
    type         = var.identity_ids == null ? "SystemAssigned" : "SystemAssigned, UserAssigned"
    identity_ids = var.identity_ids
  }
  storage_account_name       = var.storage_account.name
  storage_account_access_key = var.storage_account.access_key
  version                    = var.runtime_version
  tags                       = var.tags
  site_config {
    always_on                 = var.site_config.always_on
    ftps_state                = var.site_config.ftps_state
    http2_enabled             = var.site_config.http2_enabled
    websockets_enabled        = var.site_config.websockets_enabled
    use_32_bit_worker_process = var.site_config.use_32_bit_worker
    ip_restriction            = var.ip_restriction
    scm_ip_restriction        = var.ip_restriction

  }
  lifecycle {
    ignore_changes = [
      tags["hidden-link: /app-insights-conn-string"],
      tags["hidden-link: /app-insights-instrumentation-key"],
      tags["hidden-link: /app-insights-resource-id"],
      virtual_network_subnet_id
    ]
  }
}

resource "azurerm_app_service_virtual_network_swift_connection" "this" {
  count          = var.use_private_net ? 1 : 0
  app_service_id = azurerm_logic_app_standard.this.id
  subnet_id      = var.subnet_id
}
