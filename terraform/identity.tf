# --------------------------------------------------------------------------
# Managed Identity used BY the AKS control plane itself
# (to manage the node resource group, load balancers, etc.)
# --------------------------------------------------------------------------
resource "azurerm_user_assigned_identity" "aks_control_plane" {
  name                = "${var.project_name}-${var.environment}-aks-identity"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tags                = var.tags
}

# --------------------------------------------------------------------------
# Managed Identity used BY the application workload (pods)
# to authenticate to Azure Key Vault via Workload Identity Federation.
# --------------------------------------------------------------------------
resource "azurerm_user_assigned_identity" "workload" {
  name                = "${var.project_name}-${var.environment}-workload-identity"
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tags                = var.tags
}

# Federate the workload identity with the Kubernetes service account,
# so pods running as that service account can request an Azure AD token
# without storing any secret in the cluster.
resource "azurerm_federated_identity_credential" "workload" {
  name                = "${var.project_name}-${var.environment}-federated-credential"
  resource_group_name = azurerm_resource_group.main.name
  parent_id           = azurerm_user_assigned_identity.workload.id
  audience            = ["api://AzureADTokenExchange"]
  issuer              = azurerm_kubernetes_cluster.main.oidc_issuer_url
  subject             = "system:serviceaccount:${var.aks_service_account_namespace}:${var.aks_service_account_name}"
}

# Let the AKS control-plane identity pull images from ACR.
resource "azurerm_role_assignment" "aks_acr_pull" {
  scope                            = azurerm_container_registry.main.id
  role_definition_name             = "AcrPull"
  principal_id                     = azurerm_kubernetes_cluster.main.kubelet_identity[0].object_id
  skip_service_principal_aad_check = true
}