resource "azurerm_virtual_network_peering" "sql_mig" {
  name                      = "sql_to_mig"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.sqlserver.name
  remote_virtual_network_id = azurerm_virtual_network.migration.id
}

resource "azurerm_virtual_network_peering" "mig_sql" {
  name                      = "mig_to_sql"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.migration.name
  remote_virtual_network_id = azurerm_virtual_network.sqlserver.id
}
