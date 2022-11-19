resource "azurerm_network_security_group" "database" {
  name                = "database-nsg"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_network_security_rule" "database" {
  name                        = "disable_internet"
  priority                    = 100
  direction                   = "Outbound"
  access                      = "Deny"
  protocol                    = "*"
  source_port_range           = "*"
  destination_port_range      = "*"
  source_address_prefix       = "*"
  destination_address_prefix  = "Internet"
  resource_group_name         = var.resource_group_name
  network_security_group_name = azurerm_network_security_group.database.name
}

resource "azurerm_network_interface" "database" {
  name                = "database-nic"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.sql_server_subnet_id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_network_interface_security_group_association" "database" {
  network_interface_id      = azurerm_network_interface.database.id
  network_security_group_id = azurerm_network_security_group.database.id
}

