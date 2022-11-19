output "storage_account_name" {
  value = module.storage.storage_account.name
}

output "storage_account_blob_endpoint" {
  value = module.storage.storage_account_container.id
}

output "storage_account_sas_token" {
  sensitive = true
  value     = split("?", module.storage.storage_account_blob_sas)[1]
}

output "storage_account_primary_access_key" {
  sensitive = true
  value     = module.storage.storage_account.primary_access_key
}

output "sqlserver_private_ip_address" {
  value = module.computing.sqlserver_private_ip_address
}

# output "sql_managed_instance_name" {
#   value = module.database.azurerm_mssql_managed_instance_name
# }

# output "sql_managed_instance_public_endpoint" {
#   value = join(".", [
#     module.database.azurerm_mssql_managed_instance_name,
#     "public",
#     module.database.azurerm_mssql_managed_instance_dns_zone,
#     "database.windows.net,3342",
#   ])
# }
