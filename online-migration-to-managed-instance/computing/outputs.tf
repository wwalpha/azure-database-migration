output "sqlserver_private_ip_address" {
  value = azurerm_network_interface.database.private_ip_address
}
