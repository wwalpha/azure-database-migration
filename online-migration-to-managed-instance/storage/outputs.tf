output "storage_account_blob_sas" {
  value = data.azurerm_storage_account_blob_container_sas.this.sas
}

output "storage_account_container" {
  value = azurerm_storage_container.this
}

output "storage_account" {
  value = azurerm_storage_account.this
}
