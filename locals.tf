locals {
  location           = "eastus"
  rg_name            = "rg-aks-terraform-prod"
  environment        = "Production"
  vnet_name          = "aks-vnet"
  aks_name           = "main-aks"
  nginx_ingress_name = "ingress-nginx"
  cert_manager_name  = "cert-manager"
  dns_name           = "<YOUR_DOMAIN>"
}
