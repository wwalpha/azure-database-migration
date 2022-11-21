resource "azurerm_database_migration_service" "this" {
  name                = "dbms-${var.suffix}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = var.migration_subnet_id
  sku_name            = "Premium_4vCores"
}

