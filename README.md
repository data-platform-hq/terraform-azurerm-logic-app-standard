# Azure <> Terraform module
Terraform module for create and manage Azure Logic App Standard

## Usage

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.40.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.46.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_app_service_virtual_network_swift_connection.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service_virtual_network_swift_connection) | resource |
| [azurerm_application_insights.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights) | resource |
| [azurerm_logic_app_standard.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/logic_app_standard) | resource |
| [azurerm_monitor_diagnostic_setting.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/monitor_diagnostic_setting) | resource |
| [azurerm_monitor_diagnostic_categories.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/monitor_diagnostic_categories) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_analytics_destination_type"></a> [analytics\_destination\_type](#input\_analytics\_destination\_type) | Possible values are AzureDiagnostics and Dedicated. | `string` | `"Dedicated"` | no |
| <a name="input_analytics_workspace_id"></a> [analytics\_workspace\_id](#input\_analytics\_workspace\_id) | Resource ID of Log Analytics Workspace | `string` | `null` | no |
| <a name="input_app_settings"></a> [app\_settings](#input\_app\_settings) | Application setting | `map(string)` | `{}` | no |
| <a name="input_application_type"></a> [application\_type](#input\_application\_type) | Application type (java, python, etc) | `string` | `"web"` | no |
| <a name="input_bundle_version"></a> [bundle\_version](#input\_bundle\_version) | If use\_extension\_bundle then controls the allowed range for bundle versions | `string` | `"[1.*, 2.0.0)"` | no |
| <a name="input_disable_homepage"></a> [disable\_homepage](#input\_disable\_homepage) | A value of true disables the default landing page that is shown for the root URL of a logic app | `bool` | `true` | no |
| <a name="input_enable_appinsights"></a> [enable\_appinsights](#input\_enable\_appinsights) | Enable application insights | `bool` | `true` | no |
| <a name="input_enabled"></a> [enabled](#input\_enabled) | Enable or disable the Logic app | `bool` | `true` | no |
| <a name="input_env"></a> [env](#input\_env) | Environment | `string` | n/a | yes |
| <a name="input_https_only"></a> [https\_only](#input\_https\_only) | Enable https only | `bool` | `true` | no |
| <a name="input_identity_ids"></a> [identity\_ids](#input\_identity\_ids) | List of user assigned identity IDs | `list(string)` | `null` | no |
| <a name="input_ip_restriction"></a> [ip\_restriction](#input\_ip\_restriction) | Firewall settings for the logic app | <pre>list(object({<br>    name                      = string<br>    ip_address                = string<br>    service_tag               = string<br>    virtual_network_subnet_id = string<br>    priority                  = string<br>    action                    = string<br>    headers = list(object({<br>      x_azure_fdid      = list(string)<br>      x_fd_health_probe = list(string)<br>      x_forwarded_for   = list(string)<br>      x_forwarded_host  = list(string)<br>    }))<br>  }))</pre> | <pre>[<br>  {<br>    "action": "Allow",<br>    "headers": null,<br>    "ip_address": null,<br>    "name": "allow_azure",<br>    "priority": "100",<br>    "service_tag": "AzureCloud",<br>    "virtual_network_subnet_id": null<br>  }<br>]</pre> | no |
| <a name="input_location"></a> [location](#input\_location) | Location | `string` | n/a | yes |
| <a name="input_log_level"></a> [log\_level](#input\_log\_level) | Log level | `string` | `"info"` | no |
| <a name="input_name"></a> [name](#input\_name) | Logic app name | `string` | n/a | yes |
| <a name="input_node_version"></a> [node\_version](#input\_node\_version) | The runtime version associated with the Logic App | `string` | `"~14"` | no |
| <a name="input_project"></a> [project](#input\_project) | Project name | `string` | n/a | yes |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | Resource group name | `string` | n/a | yes |
| <a name="input_runtime_version"></a> [runtime\_version](#input\_runtime\_version) | The runtime version associated with the Logic App | `string` | `"~4"` | no |
| <a name="input_service_plan_id"></a> [service\_plan\_id](#input\_service\_plan\_id) | App Service plan ID | `string` | n/a | yes |
| <a name="input_site_config"></a> [site\_config](#input\_site\_config) | Site config for the Logic app | <pre>object({<br>    always_on          = optional(bool, false)<br>    ftps_state         = optional(string, "Disabled")<br>    http2_enabled      = optional(bool, true)<br>    websockets_enabled = optional(bool, false)<br>    use_32_bit_worker  = optional(bool, false)<br>    }<br>  )</pre> | `{}` | no |
| <a name="input_storage_account"></a> [storage\_account](#input\_storage\_account) | Storage account for the Logic app | <pre>object({<br>    name       = string<br>    access_key = string<br>  })</pre> | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | Subnet ID for the logic app | `string` | `null` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags | `map(string)` | n/a | yes |
| <a name="input_use_extension_bundle"></a> [use\_extension\_bundle](#input\_use\_extension\_bundle) | Use extension bundle | `bool` | `true` | no |
| <a name="input_use_placeholder"></a> [use\_placeholder](#input\_use\_placeholder) | Indicates whether to use a specific cold start optimization when running on the Consumption plan. Set to 0 to disable the cold-start optimization on the Consumption plan. | `string` | `"0"` | no |
| <a name="input_use_private_net"></a> [use\_private\_net](#input\_use\_private\_net) | Use private network injection | `bool` | `false` | no |
| <a name="input_worker_runtime"></a> [worker\_runtime](#input\_worker\_runtime) | The runtime version associated with the Logic App | `string` | `"node"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_default_hostname"></a> [default\_hostname](#output\_default\_hostname) | The default hostname associated with the Logic App |
| <a name="output_id"></a> [id](#output\_id) | The ID of the Logic App |
| <a name="output_identity"></a> [identity](#output\_identity) | Logic app Managed Identity |
| <a name="output_kind"></a> [kind](#output\_kind) | The Logic App kind - will be functionapp,workflowapp |
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azurerm-logic-app-standard/tree/main/LICENSE)
