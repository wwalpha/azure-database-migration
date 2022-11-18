resource "azurerm_database_migration_service" "this" {
  name                = "demo-dbms"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.subnet1.id
  sku_name            = "Standard_1vCores"
}

resource "azurerm_database_migration_project" "this" {
  name                = "sql_to_sqldb"
  service_name        = azurerm_database_migration_service.this.name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  source_platform     = "SQL"
  target_platform     = "SQLDB"
}
