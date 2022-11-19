output "sql_managed_instance_vnet" {
  value = azurerm_virtual_network.database
}

output "sql_managed_instance_subnet" {
  value = azurerm_subnet.database
}

output "sqlserver_vnet" {
  value = azurerm_virtual_network.sqlserver
}

output "sqlserver_subnet" {
  value = azurerm_subnet.sqlserver
}

output "migration_vnet" {
  value = azurerm_virtual_network.migration
}

output "migration_subnet" {
  value = azurerm_subnet.migration
}
