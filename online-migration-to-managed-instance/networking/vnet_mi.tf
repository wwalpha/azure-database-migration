resource "azurerm_virtual_network" "database" {
  name                = "database-vnet-${var.suffix}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = ["10.10.0.0/16"]
}

resource "azurerm_subnet" "database" {
  name                 = "database-${var.suffix}"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.database.name
  address_prefixes     = ["10.10.1.0/24"]

  delegation {
    name = "managedinstancedelegation"

    service_delegation {
      name = "Microsoft.Sql/managedInstances"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/join/action",
        "Microsoft.Network/virtualNetworks/subnets/prepareNetworkPolicies/action",
        "Microsoft.Network/virtualNetworks/subnets/unprepareNetworkPolicies/action"
      ]
    }
  }
}

resource "azurerm_network_security_group" "database" {
  name                = "mi-sg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "this" {
  subnet_id                 = azurerm_subnet.database.id
  network_security_group_id = azurerm_network_security_group.database.id
}

resource "azurerm_route_table" "database" {
  depends_on                    = [azurerm_subnet.database]
  name                          = "routetable-mi"
  location                      = var.resource_group_location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = false
}

resource "azurerm_subnet_route_table_association" "database" {
  subnet_id      = azurerm_subnet.database.id
  route_table_id = azurerm_route_table.database.id
}
