resource "azurerm_database_migration_service" "this" {
  name                = "demo-dbms"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  subnet_id           = azurerm_subnet.subnet1.id
  sku_name            = "Standard_1vCores"
}
