output "storage_account_id" {
  value = azurerm_storage_account.this.id
}

output "storage_account_name" {
  value = azurerm_storage_account.this.name
}

output "storage_account_sas" {
  value = data.azurerm_storage_account_sas.this.sas
}

output "storage_account_container" {
  value = azurerm_storage_container.this.name
}
