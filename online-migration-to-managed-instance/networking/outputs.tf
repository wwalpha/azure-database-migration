output "managed_instance_database_vnet_id" {
  value = azurerm_virtual_network.database.id
}

output "managed_instance_database_subnet_id" {
  value = azurerm_subnet.database.id
}

output "sql_server_vnet_id" {
  value = azurerm_virtual_network.sqlserver.id
}

output "sql_server_subnet_id" {
  value = azurerm_subnet.sqlserver.id
}
