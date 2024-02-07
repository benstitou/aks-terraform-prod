output "client_certificate" {
  value     = azurerm_kubernetes_cluster.main_aks.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.main_aks.kube_config_raw
  sensitive = true
}

output "ingress_nginx_pip" {
  value = data.azurerm_public_ip.ingress_nginx_pip.ip_address
}
