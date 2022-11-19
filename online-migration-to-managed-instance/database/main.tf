resource "azurerm_mssql_managed_instance" "this" {
  name                         = "mi-${var.suffix}"
  resource_group_name          = var.resource_group_name
  location                     = var.resource_group_location
  license_type                 = "BasePrice"
  sku_name                     = "GP_Gen5"
  vcores                       = 4
  storage_size_in_gb           = 32
  subnet_id                    = var.subnet_id
  administrator_login          = var.mssql_admin_username
  administrator_login_password = var.mssql_admin_password
  storage_account_type         = "LRS"
  minimum_tls_version          = "1.2"
  public_data_endpoint_enabled = true
}
