resource "azurerm_virtual_network" "vn_prod" {
  name                = local.vnet_name
  location            = azurerm_resource_group.rg_prod.location
  resource_group_name = azurerm_resource_group.rg_prod.name
  address_space       = ["10.8.0.0/16"]

  tags = {
    environment = local.environment
  }
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = "aks-subnet"
  resource_group_name  = azurerm_resource_group.rg_prod.name
  virtual_network_name = azurerm_virtual_network.vn_prod.name
  address_prefixes     = ["10.8.0.0/21"]
}

resource "azurerm_subnet" "applications_subnet" {
  name                 = "application-subnet"
  resource_group_name  = azurerm_resource_group.rg_prod.name
  virtual_network_name = azurerm_virtual_network.vn_prod.name
  address_prefixes     = ["10.8.8.0/21"]
}

resource "azurerm_dns_zone" "ingress" {
  name                = local.dns_name
  resource_group_name = azurerm_resource_group.rg_prod.name
}

resource "azurerm_dns_a_record" "ingress" {
  name                = "myingress"
  zone_name           = azurerm_dns_zone.ingress.name
  resource_group_name = azurerm_resource_group.rg_prod.name
  ttl                 = 3600
  records             = [data.azurerm_public_ip.ingress_nginx_pip.ip_address]
}

resource "azurerm_public_ip" "ingress_nginx_pip" {
  name                = "ingress-nginx-pip"
  location            = azurerm_resource_group.rg_prod.location
  resource_group_name = azurerm_resource_group.rg_prod.name
  allocation_method   = "Static"
  sku                 = "Standard"

  tags = {
    environment = local.environment
  }
}
