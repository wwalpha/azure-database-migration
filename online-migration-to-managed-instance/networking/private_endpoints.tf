resource "azurerm_private_endpoint" "mig_storage" {
  name                = "migration_storage_endpoint"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.migration.id

  private_service_connection {
    name                           = "migration_storage_endpoint"
    private_connection_resource_id = var.storage_account_id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }

  private_dns_zone_group {
    name = "default"
    private_dns_zone_ids = [
      azurerm_private_dns_zone.blob_storage.id
    ]
  }
}

data "azurerm_private_endpoint_connection" "mig_storage" {
  name                = azurerm_private_endpoint.mig_storage.name
  resource_group_name = var.resource_group_name
}

# resource "azurerm_private_endpoint" "database_storage" {
#   name                = "database_storage_endpoint"
#   location            = var.resource_group_location
#   resource_group_name = var.resource_group_name
#   subnet_id           = var.database_subnet_id

#   private_service_connection {
#     name                           = "database_storage_endpoint"
#     private_connection_resource_id = azurerm_storage_account.this.id
#     is_manual_connection           = false
#     subresource_names              = ["blob"]
#   }

#   private_dns_zone_group {
#     name = "default"
#     private_dns_zone_ids = [
#       azurerm_private_dns_zone.blob_storage.id
#     ]
#   }
# }

# data "azurerm_private_endpoint_connection" "database_storage" {
#   name                = azurerm_private_endpoint.database_storage.name
#   resource_group_name = var.resource_group_name
# }
