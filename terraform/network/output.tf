output "vnet_subnets" {
  value = azurerm_virtual_network.this.subnet.*.id
}

# output "database_subnets" {
#   value = azurerm_virtual_network.database.subnet.*.id
# }
