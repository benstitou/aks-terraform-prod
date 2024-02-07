terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.88.0"
    }

    helm = {
      source  = "hashicorp/helm"
      version = "= 2.12.1"
    }
  }
}

provider "azurerm" {
  features {}
}

provider "helm" {
  # debug   = true
  kubernetes {
    host = data.azurerm_kubernetes_cluster.main_aks.kube_config[0].host

    client_key             = base64decode(data.azurerm_kubernetes_cluster.main_aks.kube_config[0].client_key)
    client_certificate     = base64decode(data.azurerm_kubernetes_cluster.main_aks.kube_config[0].client_certificate)
    cluster_ca_certificate = base64decode(data.azurerm_kubernetes_cluster.main_aks.kube_config[0].cluster_ca_certificate)
  }
}
