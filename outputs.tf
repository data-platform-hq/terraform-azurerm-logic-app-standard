
output "id" {
  value       = azurerm_logic_app_standard.this.id
  description = "The ID of the Logic App"
}

output "default_hostname" {
  value       = azurerm_logic_app_standard.this.default_hostname
  description = "The default hostname associated with the Logic App"
}

output "identity" {
  value       = azurerm_logic_app_standard.this.identity[*]
  description = "Logic app Managed Identity"
}

output "kind" {
  value       = azurerm_logic_app_standard.this.kind
  description = "The Logic App kind - will be functionapp,workflowapp"
}
