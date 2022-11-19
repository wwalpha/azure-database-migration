output "storage_account_name" {
  value = module.storage.storage_account_name
}

output "managed_instance_name" {
  value = module.database.azurerm_mssql_managed_instance_name
}

output "sqlserver_private_ip_address" {
  value = module.computing.sqlserver_private_ip_address
}
