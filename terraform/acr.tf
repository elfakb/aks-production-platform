resource "azurerm_container_registry" "main" {
  name                = "${var.project_name}${var.environment}acr"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  sku                 = "Basic"

  # Admin user is disabled on purpose — AKS pulls images via its
  # Managed Identity + role assignment instead of static credentials.
  admin_enabled = false

  tags = var.tags
}