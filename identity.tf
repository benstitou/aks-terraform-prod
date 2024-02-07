resource "azurerm_user_assigned_identity" "user_aid" {
  name                = "aks-example-identity"
  resource_group_name = azurerm_resource_group.rg_prod.name
  location            = azurerm_resource_group.rg_prod.location
}

resource "azurerm_role_assignment" "network_contributor" {
  scope                = azurerm_resource_group.rg_prod.id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_user_assigned_identity.user_aid.principal_id
}
