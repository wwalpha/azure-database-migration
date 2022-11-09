
# resource "azurerm_firewall" "example" {
#   depends_on = [
#     module.network
#   ]
#   name                = "AzureFirewall_demo-vhub"
#   location            = azurerm_resource_group.this.location
#   resource_group_name = azurerm_resource_group.this.name
#   sku_name            = "AZFW_Hub"
#   sku_tier            = "Standard"
#   firewall_policy_id  = azurerm_firewall_policy.example.id

#   virtual_hub {
#     virtual_hub_id  = module.network.virtual_hub_id
#     public_ip_count = 2
#   }
# }

# resource "azurerm_firewall_policy" "example" {
#   name                = "allow-internet"
#   location            = azurerm_resource_group.this.location
#   resource_group_name = azurerm_resource_group.this.name
#   sku                 = "Standard"
# }

# resource "azurerm_firewall_policy_rule_collection_group" "example" {
#   name               = "example-fwpolicy-rcg"
#   firewall_policy_id = azurerm_firewall_policy.example.id
#   priority           = 500

#   # application_rule_collection {
#   #   name     = "app_rule_collection1"
#   #   priority = 500
#   #   action   = "Deny"
#   #   rule {
#   #     name = "app_rule_collection1_rule1"
#   #     protocols {
#   #       type = "Http"
#   #       port = 80
#   #     }
#   #     protocols {
#   #       type = "Https"
#   #       port = 443
#   #     }
#   #     source_addresses  = ["10.0.0.1"]
#   #     destination_fqdns = ["*.microsoft.com"]
#   #   }
#   # }

#   network_rule_collection {
#     name     = "allow-internet"
#     priority = 100
#     action   = "Allow"
#     rule {
#       name                  = "internet"
#       protocols             = ["Any"]
#       source_addresses      = ["*"]
#       source_ip_groups      = []
#       destination_addresses = ["*"]
#       destination_ports     = ["443"]
#     }
#   }

#   # nat_rule_collection {
#   #   name     = "nat_rule_collection1"
#   #   priority = 300
#   #   action   = "Dnat"
#   #   rule {
#   #     name                = "nat_rule_collection1_rule1"
#   #     protocols           = ["TCP", "UDP"]
#   #     source_addresses    = ["10.0.0.1", "10.0.0.2"]
#   #     destination_address = "192.168.1.1"
#   #     destination_ports   = ["80"]
#   #     translated_address  = "192.168.0.1"
#   #     translated_port     = "8080"
#   #   }
#   # }
# }
