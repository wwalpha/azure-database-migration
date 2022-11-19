resource "azurerm_storage_account" "this" {
  name                          = "storage${var.suffix}"
  resource_group_name           = var.resource_group_name
  location                      = var.resource_group_location
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  public_network_access_enabled = true
  min_tls_version               = "TLS1_0"
}

resource "azurerm_storage_container" "this" {
  name                  = "backup"
  storage_account_name  = azurerm_storage_account.this.name
  container_access_type = "private"
}

data "azurerm_storage_account_blob_container_sas" "this" {
  connection_string = azurerm_storage_account.this.primary_connection_string
  container_name    = azurerm_storage_container.this.name
  https_only        = true

  start  = "2022-11-01"
  expiry = "2022-12-31"

  permissions {
    read   = true
    add    = true
    create = true
    write  = true
    delete = false
    list   = false
  }
}
