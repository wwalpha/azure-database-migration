resource "azurerm_virtual_network" "this" {
  name                = "demo-vent"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]

  subnet {
    name           = "subnet1"
    address_prefix = "10.0.1.0/24"
    security_group = ""
  }

  subnet {
    name           = "subnet2"
    address_prefix = "10.0.2.0/24"
    security_group = ""
  }
}

resource "azurerm_private_link_service" "mssql" {
  name                = "app-privatelink"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_private_endpoint" "mssql" {
  name                = "mssql-endpoint"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_virtual_network.this.subnet.*.id[0]

  private_service_connection {
    name                           = "mssql-connection"
    private_connection_resource_id = azurerm_private_link_service.mssql.id
    is_manual_connection           = false
  }
}
