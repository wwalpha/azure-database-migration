resource "azurerm_virtual_network" "this" {
  name                = "app-vnet"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
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

resource "azurerm_nat_gateway" "this" {
  name                    = "nat-Gateway"
  location                = var.resource_group_location
  resource_group_name     = var.resource_group_name
  sku_name                = "Standard"
  idle_timeout_in_minutes = 10
  zones                   = ["1"]
}

resource "azurerm_public_ip" "natgw" {
  name                = "natgw-ip"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_nat_gateway_public_ip_association" "this" {
  nat_gateway_id       = azurerm_nat_gateway.this.id
  public_ip_address_id = azurerm_public_ip.natgw.id
}


resource "azurerm_route_table" "subnet1" {
  name                = "rt-subnet1"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  route {
    name           = "internet"
    address_prefix = "0.0.0.0/0"
    next_hop_type  = "VirtualNetworkGateway"
  }
}

resource "azurerm_subnet_route_table_association" "subnet1" {
  subnet_id      = azurerm_subnet.subnet1.id
  route_table_id = azurerm_route_table.subnet1.id
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
