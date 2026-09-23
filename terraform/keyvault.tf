resource "azurerm_key_vault" "main" {
  name                       = "${var.project_name}-${var.environment}-kv"
  location                   = azurerm_resource_group.main.location
  resource_group_name        = azurerm_resource_group.main.name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  sku_name                   = "standard"
  purge_protection_enabled   = false
  soft_delete_retention_days = 7

  tags = var.tags
}

# Allow the Terraform operator (you) to manage secrets during setup.
resource "azurerm_role_assignment" "kv_admin_current_user" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Administrator"
  principal_id          = data.azurerm_client_config.current.object_id
}

# Allow the application's workload identity to READ secrets only.
resource "azurerm_role_assignment" "kv_reader_workload" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Secrets User"
  principal_id          = azurerm_user_assigned_identity.workload.principal_id
}

# Example application secret — replace with real values later,
# or manage this outside Terraform for real secrets.
resource "azurerm_key_vault_secret" "app_db_password" {
  name         = "app-db-password"
  value        = "ChangeMeInRealDeployment!"
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [azurerm_role_assignment.kv_admin_current_user]
}