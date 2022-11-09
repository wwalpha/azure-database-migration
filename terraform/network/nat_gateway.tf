
# resource "azurerm_public_ip" "natgw" {
#   name                = "natgw-ip"
#   location            = var.resource_group_location
#   resource_group_name = var.resource_group_name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# resource "azurerm_nat_gateway" "this" {
#   name                    = "nat-Gateway"
#   location                = var.resource_group_location
#   resource_group_name     = var.resource_group_name
#   sku_name                = "Standard"
#   idle_timeout_in_minutes = 10
# }

# resource "azurerm_nat_gateway_public_ip_association" "this" {
#   nat_gateway_id       = azurerm_nat_gateway.this.id
#   public_ip_address_id = azurerm_public_ip.natgw.id
# }

# resource "azurerm_subnet_nat_gateway_association" "subnet1" {
#   subnet_id      = azurerm_subnet.subnet1.id
#   nat_gateway_id = azurerm_nat_gateway.this.id
# }

# resource "azurerm_route_table" "subnet1" {
#   name                = "rt-subnet1"
#   location            = var.resource_group_location
#   resource_group_name = var.resource_group_name

#   route {
#     name           = "internet"
#     address_prefix = "0.0.0.0/0"
#     next_hop_type  = "VirtualNetworkGateway"
#   }
# }

# resource "azurerm_subnet_route_table_association" "subnet1" {
#   subnet_id      = azurerm_subnet.subnet1.id
#   route_table_id = azurerm_route_table.subnet1.id
# }
