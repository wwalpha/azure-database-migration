resource "azurerm_virtual_network_peering" "sql_mig" {
  depends_on                = [azurerm_virtual_network_gateway.this]
  name                      = "sql_to_mig"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.sqlserver.name
  remote_virtual_network_id = azurerm_virtual_network.migration.id
  allow_forwarded_traffic   = true
  use_remote_gateways       = true
}

resource "azurerm_virtual_network_peering" "mig_sql" {
  depends_on                = [azurerm_virtual_network_gateway.this]
  name                      = "mig_to_sql"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.migration.name
  remote_virtual_network_id = azurerm_virtual_network.sqlserver.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = true
}
