resource "azurerm_private_dns_zone" "private_link" {
  name                = "privatelink.database.windows.net"
  resource_group_name = var.resource_group_name
}

# Link the Private DNS Zone with the VNET
resource "azurerm_private_dns_zone_virtual_network_link" "private_link_dns" {
  name                  = "pl-vnet"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.private_link.name
  virtual_network_id    = azurerm_virtual_network.this.id
  registration_enabled  = true
}

# Create a DB Private DNS A Record
resource "azurerm_private_dns_a_record" "mssql" {
  name                = "mssqlserver20221108"
  zone_name           = azurerm_private_dns_zone.private_link.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [data.azurerm_private_endpoint_connection.mssql_endpoint.private_service_connection.0.private_ip_address]
}
