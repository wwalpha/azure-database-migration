resource "azurerm_mssql_server" "this" {
  name                          = "mssqlserver20221108"
  location                      = var.resource_group_location
  resource_group_name           = var.resource_group_name
  version                       = "12.0"
  administrator_login           = var.mssql_admin_username
  administrator_login_password  = var.mssql_admin_password
  minimum_tls_version           = "1.2"
  public_network_access_enabled = false
}

resource "azurerm_mssql_database" "this" {
  name           = "mssqlserver20221108"
  server_id      = azurerm_mssql_server.this.id
  sku_name       = "S0"
  max_size_gb    = 100
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  read_scale     = false
  zone_redundant = false
}
