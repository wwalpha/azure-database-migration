# resource "azurerm_subnet" "bastion" {
#   name                 = "AzureBastionSubnet"
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = azurerm_virtual_network.this.name
#   address_prefixes     = ["10.0.3.0/24"]
# }

# resource "azurerm_public_ip" "bastion" {
#   name                = "bastion-ip"
#   location            = var.resource_group_location
#   resource_group_name = var.resource_group_name
#   allocation_method   = "Static"
#   sku                 = "Standard"
# }

# resource "azurerm_bastion_host" "this" {
#   name                = "bastion"
#   location            = var.resource_group_location
#   resource_group_name = var.resource_group_name
#   copy_paste_enabled  = true

#   ip_configuration {
#     name                 = "configuration"
#     subnet_id            = azurerm_subnet.bastion.id
#     public_ip_address_id = azurerm_public_ip.bastion.id
#   }
# }
