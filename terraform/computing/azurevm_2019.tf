# resource "azurerm_network_interface" "win2019" {
#   name                = "win2019-nic"
#   location            = var.resource_group_location
#   resource_group_name = var.resource_group_name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = var.vnet_subnets[0]
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_windows_virtual_machine" "win2019" {
#   name                = "win2019-vm"
#   location            = var.resource_group_location
#   resource_group_name = var.resource_group_name
#   size                = "Standard_B2ms"
#   admin_username      = var.azurevm_admin_username
#   admin_password      = var.azurevm_admin_password
#   network_interface_ids = [
#     azurerm_network_interface.win2019.id
#   ]

#   os_disk {
#     caching              = "ReadWrite"
#     storage_account_type = "Standard_LRS"
#   }

#   source_image_reference {
#     publisher = "MicrosoftWindowsServer"
#     offer     = "WindowsServer"
#     sku       = "2019-datacenter-gensecond"
#     version   = "latest"
#   }
# }
