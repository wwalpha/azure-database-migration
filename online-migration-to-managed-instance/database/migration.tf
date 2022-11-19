resource "azurerm_database_migration_service" "this" {
  name                = "dbms-${var.suffix}"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = var.migration_subnet_id
  sku_name            = "Standard_1vCores"
}

# resource "azurerm_database_migration_project" "this" {
#   name                = "dbms-project-${var.suffix}"
#   service_name        = azurerm_database_migration_service.this.name
#   location            = var.resource_group_location
#   resource_group_name = var.resource_group_name
#   source_platform     = "SQL"
#   target_platform     = "SQLDB"
# }
