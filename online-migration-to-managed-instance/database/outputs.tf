# output "azurerm_mssql_managed_instance_id" {
#   value = azurerm_mssql_managed_instance.this.id
# }

# output "azurerm_mssql_managed_instance_name" {
#   value = azurerm_mssql_managed_instance.this.name
# }

# output "azurerm_mssql_managed_instance_dns_zone" {
#   value = split(".", azurerm_mssql_managed_instance.this.fqdn)[1]
# }

output "self_hosted_ir_keys" {
  value = data.external.shir_keys.result
}
