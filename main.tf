
resource "azurerm_resource_group" "rg_prod" {
  name     = local.rg_name
  location = local.location
}
