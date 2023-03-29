variable "project" {
  type        = string
  description = "Project name"
}

variable "env" {
  type        = string
  description = "Environment"
}

variable "location" {
  type        = string
  description = "Location"
}

variable "tags" {
  type        = map(string)
  description = "Tags"
}

variable "resource_group" {
  type        = string
  description = "Resource group name"
}


variable "service_plan_id" {
  type        = string
  description = "App Service plan ID"
}

variable "name" {
  type        = string
  description = "Logic app name"
}

variable "application_type" {
  type        = string
  description = "Application type (java, python, etc)"
  default     = "web"
}

variable "ip_restriction" {
  description = "Firewall settings for the logic app"
  type = list(object({
    name                      = string
    ip_address                = string
    service_tag               = string
    virtual_network_subnet_id = string
    priority                  = string
    action                    = string
    headers = list(object({
      x_azure_fdid      = list(string)
      x_fd_health_probe = list(string)
      x_forwarded_for   = list(string)
      x_forwarded_host  = list(string)
    }))
  }))
  default = [
    {
      name                      = "allow_azure"
      ip_address                = null
      service_tag               = "AzureCloud"
      virtual_network_subnet_id = null
      priority                  = "100"
      action                    = "Allow"
      headers                   = null
    }
  ]
}

variable "app_settings" {
  type        = map(string)
  default     = {}
  description = "Application setting"
}

variable "subnet_id" {
  type        = string
  description = "Subnet ID for the logic app"
  default     = null
}

variable "identity_ids" {
  type        = list(string)
  description = "List of user assigned identity IDs"
  default     = null
}

variable "enable_appinsights" {
  type        = bool
  description = "Enable application insights"
  default     = true
}

variable "analytics_workspace_id" {
  type        = string
  description = "Resource ID of Log Analytics Workspace"
  default     = null
}

variable "analytics_destination_type" {
  type        = string
  description = "Possible values are AzureDiagnostics and Dedicated."
  default     = "Dedicated"
}

variable "use_extension_bundle" {
  type        = bool
  description = "Use extension bundle"
  default     = true
}

variable "bundle_version" {
  type        = string
  description = "If use_extension_bundle then controls the allowed range for bundle versions"
  default     = "[1.*, 2.0.0)"
}

variable "enabled" {
  type        = bool
  description = "Enable or disable the Logic app"
  default     = true
}

variable "site_config" {
  description = "Site config for the Logic app"
  type = object({
    always_on          = optional(bool, false)
    ftps_state         = optional(string, "Disabled")
    http2_enabled      = optional(bool, true)
    websockets_enabled = optional(bool, false)
    use_32_bit_worker  = optional(bool, false)
    }
  )
  default = {}
}

variable "https_only" {
  type        = bool
  description = "Enable https only"
  default     = true
}

variable "runtime_version" {
  type        = string
  description = "The runtime version associated with the Logic App"
  default     = "~4"
}

variable "worker_runtime" {
  type        = string
  description = "The runtime version associated with the Logic App"
  default     = "node"
}

variable "node_version" {
  type        = string
  description = "The runtime version associated with the Logic App"
  default     = "~14"
}

variable "storage_account" {
  description = "Storage account for the Logic app"
  type = object({
    name       = string
    access_key = string
  })
}

variable "use_private_net" {
  type        = bool
  description = "Use private network injection"
  default     = false
}

variable "log_level" {
  type        = string
  description = "Log level"
  default     = "info"
}

variable "disable_homepage" {
  type        = bool
  description = "A value of true disables the default landing page that is shown for the root URL of a logic app"
  default     = true
}

variable "use_placeholder" {
  type        = string
  description = "Indicates whether to use a specific cold start optimization when running on the Consumption plan. Set to 0 to disable the cold-start optimization on the Consumption plan."
  default     = "0"
}
