
# resource "azurerm_private_endpoint" "mssql" {
#   name                = "mssql_endpoint"
#   location            = var.resource_group_location
#   resource_group_name = var.resource_group_name
#   subnet_id           = azurerm_subnet.subnet1.id

#   private_service_connection {
#     name                              = "mssql_endpoint"
#     private_connection_resource_alias = "example-privatelinkservice.d20286c8-4ea5-11eb-9584-8f53157226c6.centralus.azure.privatelinkservice"
#     is_manual_connection              = true
#     request_message                   = "PL"
#     subresource_names                 = ["sqlServer"]
#   }

#   private_dns_zone_group {
#     name = "default"
#     private_dns_zone_ids = [
#       azurerm_private_dns_zone.private_link.id
#     ]
#   }
# }


# Create a DB Private Endpoint
resource "azurerm_private_endpoint" "mssql_endpoint" {
  name                = "mssql_endpoint"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.subnet1.id

  private_service_connection {
    name                           = "mssql_endpoint"
    is_manual_connection           = "false"
    private_connection_resource_id = var.mssql_server_id
    subresource_names              = ["sqlServer"]
  }
}

# DB Private Endpoint Connecton
data "azurerm_private_endpoint_connection" "mssql_endpoint" {
  name                = azurerm_private_endpoint.mssql_endpoint.name
  resource_group_name = var.resource_group_name
}
