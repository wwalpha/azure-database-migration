resource "azurerm_virtual_network" "this" {
  name                = "app-vnet"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
  dns_servers         = ["10.0.0.4", "10.0.0.5"]
}

resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "subnet2" {
  name                 = "subnet2"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.2.0/24"]
}

# resource "azurerm_private_link_service" "mssql" {
#   name                = "app-privatelink"
#   location            = var.resource_group_location
#   resource_group_name = var.resource_group_name
# }

# resource "azurerm_private_endpoint" "mssql" {
#   name                = "mssql-endpoint"
#   location            = var.resource_group_location
#   resource_group_name = var.resource_group_name
#   subnet_id           = azurerm_subnet.subnet1.id

#   private_service_connection {
#     name                           = "mssql-connection"
#     private_connection_resource_id = azurerm_private_link_service.mssql.id
#     is_manual_connection           = false
#   }
# }
