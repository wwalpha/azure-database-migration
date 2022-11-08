output "azurerm_win2012_private_ip_address" {
  value = module.computing.azurerm_win2012.private_ip_address
}

output "azurerm_win2019_private_ip_address" {
  value = module.computing.azurerm_win2019.private_ip_address
}
