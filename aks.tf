resource "azurerm_kubernetes_cluster" "main_aks" {
  name                      = local.aks_name
  location                  = azurerm_resource_group.rg_prod.location
  resource_group_name       = azurerm_resource_group.rg_prod.name
  dns_prefix                = "aksprod"
  sku_tier                  = "Standard"
  kubernetes_version        = "1.27"
  automatic_channel_upgrade = "stable"
  node_resource_group       = "${local.rg_name}-${local.aks_name}-prod"

  default_node_pool {
    name                = "default"
    node_count          = 1
    min_count           = 1
    max_count           = 5
    vm_size             = "Standard_D2_v2"
    vnet_subnet_id      = azurerm_subnet.aks_subnet.id
    enable_auto_scaling = true
    type                = "VirtualMachineScaleSets"

    node_labels = {
      role = "main"
    }
  }

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.user_aid.id]
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    service_cidr   = "10.0.0.0/16"
    dns_service_ip = "10.0.0.10"

    #load_balancer_profile {
    #outbound_ip_address_ids = [azurerm_public_ip.ingress_nginx_pip.id]
    #}

  }

  depends_on = [
    azurerm_role_assignment.network_contributor
  ]

  tags = {
    environment = local.environment
  }

  lifecycle {
    ignore_changes = [default_node_pool[0].node_count]
  }
}

resource "azurerm_kubernetes_cluster_node_pool" "main" {
  name                  = "main"
  kubernetes_cluster_id = azurerm_kubernetes_cluster.main_aks.id
  vm_size               = "Standard_DS2_v2"
  node_count            = 1
  min_count             = 1
  max_count             = 5
  vnet_subnet_id        = azurerm_subnet.aks_subnet.id
  orchestrator_version  = azurerm_kubernetes_cluster.main_aks.kubernetes_version

  enable_auto_scaling = true
  node_labels = {
    role = "worker01"
  }

  tags = {
    Environment = local.environment
  }

  lifecycle {
    ignore_changes = [node_count]
  }
}
