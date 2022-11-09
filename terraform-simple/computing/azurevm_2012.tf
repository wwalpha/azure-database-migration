data "azurerm_image" "sqlserver2012" {
  name                = "win2012-sqlserver2012-adventures"
  resource_group_name = "DEV_RG"
}

resource "azurerm_windows_virtual_machine" "win2012" {
  depends_on            = [azurerm_network_interface_security_group_association.win2012]
  name                  = "win2012-vm"
  location              = var.resource_group_location
  resource_group_name   = var.resource_group_name
  size                  = "Standard_B2ms"
  admin_username        = var.azurevm_admin_username
  admin_password        = var.azurevm_admin_password
  network_interface_ids = [azurerm_network_interface.win2012.id]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_id = data.azurerm_image.sqlserver2012.id
}
