resource "azurerm_storage_account" "this" {
  name                          = "storage${var.suffix}"
  resource_group_name           = var.resource_group_name
  location                      = var.resource_group_location
  account_tier                  = "Standard"
  account_replication_type      = "LRS"
  min_tls_version               = "TLS1_2"
  public_network_access_enabled = true
  enable_https_traffic_only     = true

  network_rules {
    default_action = "Deny"
    bypass         = ["Metrics", "AzureServices"]
  }
}

# resource "azurerm_storage_account_network_rules" "this" {
#   storage_account_id         = azurerm_storage_account.this.id
#   default_action             = "Allow"
#   virtual_network_subnet_ids = [var.database_subnet_id]
# }

# resource "azurerm_storage_container" "this" {
#   name                  = "backup"
#   storage_account_name  = azurerm_storage_account.this.name
#   container_access_type = "private"
# }

# data "azurerm_storage_account_blob_container_sas" "this" {
#   connection_string = azurerm_storage_account.this.primary_connection_string
#   container_name    = azurerm_storage_container.this.name
#   https_only        = true

#   start  = "2022-11-01"
#   expiry = "2022-12-31"

#   permissions {
#     read   = true
#     add    = true
#     create = true
#     write  = true
#     delete = false
#     list   = false
#   }
# }
