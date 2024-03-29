resource "azurerm_virtual_network" "database" {
  name                = "database-vnet-${var.suffix}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = ["10.10.0.0/16"]
}

resource "azurerm_subnet" "database" {
  depends_on                  = [null_resource.service_endpoint_policy]
  name                        = "database-${var.suffix}"
  resource_group_name         = var.resource_group_name
  virtual_network_name        = azurerm_virtual_network.database.name
  address_prefixes            = ["10.10.1.0/24"]
  service_endpoints           = ["Microsoft.Storage"]
  service_endpoint_policy_ids = [local.service_endpoint_storage_policy_id]

  delegation {
    name = "Microsoft.Sql.managedInstances"

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

resource "azurerm_network_security_rule" "allow_internet" {
  name                        = "AllowMyIpAddress"
  priority                    = 1001
  direction                   = "Inbound"
  access                      = "Allow"
  protocol                    = "Tcp"
  source_port_range           = "*"
  destination_port_range      = "3342"
  source_address_prefix       = var.my_ip_address
  destination_address_prefix  = "*"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.database.name
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

resource "azurerm_storage_account_network_rules" "this" {
  storage_account_id         = var.storage_account_id
  default_action             = "Allow"
  virtual_network_subnet_ids = [azurerm_subnet.database.id]
}
