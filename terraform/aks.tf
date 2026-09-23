resource "azurerm_kubernetes_cluster" "main" {
  name                = "${var.project_name}-${var.environment}-aks"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  dns_prefix          = "${var.project_name}-${var.environment}"
  kubernetes_version  = var.kubernetes_version

  # Free tier: no SLA on the control plane, but $0/hour for the
  # control plane itself — appropriate for a portfolio/demo cluster.
  sku_tier = "Free"

  default_node_pool {
    name           = "system"
    node_count     = var.node_count
    vm_size        = var.node_vm_size
    vnet_subnet_id = azurerm_subnet.aks.id

    upgrade_settings {
      max_surge = "10%"
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks_control_plane.id]
  }

  # Enables OIDC issuer + workload identity, required for federated
  # credentials (pods authenticating to Azure AD without secrets).
  oidc_issuer_enabled      = true
  workload_identity_enabled = true

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    service_cidr   = "10.20.0.0/24"
    dns_service_ip = "10.20.0.10"
  }

  tags = var.tags
}