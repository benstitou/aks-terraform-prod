data "azurerm_kubernetes_cluster" "main_aks" {
  name                = local.aks_name
  resource_group_name = local.rg_name
  depends_on = [
    azurerm_kubernetes_cluster.main_aks
  ]
}

data "azurerm_public_ip" "ingress_nginx_pip" {
  name                = azurerm_public_ip.ingress_nginx_pip.name
  resource_group_name = local.rg_name
}
