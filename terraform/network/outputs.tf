output "vnet_subnets" {
  value = [azurerm_subnet.subnet1.id, azurerm_subnet.subnet2.id]
}

# output "database_subnets" {
#   value = azurerm_virtual_network.database.subnet.*.id
# }

output "virtual_hub_id" {
  value = azurerm_virtual_hub.this.id
}
