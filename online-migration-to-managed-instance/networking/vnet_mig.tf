resource "azurerm_virtual_network" "migration" {
  name                = "migration-vnet-${var.suffix}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = ["10.1.0.0/16"]
}

resource "azurerm_subnet" "migration_gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.migration.name
  address_prefixes     = ["10.1.0.0/24"]
}

resource "azurerm_subnet" "migration" {
  name                 = "migration-${var.suffix}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.migration.name
  address_prefixes     = ["10.1.1.0/24"]
}
