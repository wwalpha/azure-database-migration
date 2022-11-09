resource "azurerm_virtual_wan" "this" {
  name                = "demo-vwan"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_hub" "this" {
  name                = "demo-vhub"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  virtual_wan_id      = azurerm_virtual_wan.this.id
  address_prefix      = "10.20.0.0/16"
}

data "azurerm_client_config" "this" {}

resource "azurerm_vpn_server_configuration" "this" {
  name                     = "vpn-config"
  location                 = var.resource_group_location
  resource_group_name      = var.resource_group_name
  vpn_authentication_types = ["AAD"]
  vpn_protocols            = ["OpenVPN"]

  azure_active_directory_authentication {
    tenant   = "https://login.microsoftonline.com/${data.azurerm_client_config.this.tenant_id}"
    audience = "41b23e61-6c1e-4545-b367-cd054e0ed4b4"
    issuer   = "https://sts.windows.net/${data.azurerm_client_config.this.tenant_id}/"
  }
}

resource "azurerm_point_to_site_vpn_gateway" "this" {
  name                        = "p2s-vpngw"
  location                    = var.resource_group_location
  resource_group_name         = var.resource_group_name
  vpn_server_configuration_id = azurerm_vpn_server_configuration.this.id
  virtual_hub_id              = azurerm_virtual_hub.this.id
  scale_unit                  = 1

  connection_configuration {
    name = "gateway-config"

    vpn_client_address_pool {
      address_prefixes = [
        "172.16.0.0/24"
      ]
    }
  }
}

resource "azurerm_virtual_hub_connection" "app_vnet" {
  name                      = "app_vnet"
  virtual_hub_id            = azurerm_virtual_hub.this.id
  remote_virtual_network_id = azurerm_virtual_network.this.id
}

resource "azurerm_virtual_hub_route_table_route" "vpn_to_app_vnet" {
  route_table_id = azurerm_virtual_hub.this.default_route_table_id

  name              = "app-route"
  destinations_type = "CIDR"
  destinations      = ["10.0.0.0/16"]
  next_hop_type     = "ResourceId"
  next_hop          = azurerm_virtual_hub_connection.app_vnet.id
}

# resource "azurerm_virtual_hub_route_table" "vpn_to_app_net" {
#   name           = "vpn-app"
#   virtual_hub_id = azurerm_virtual_hub.this.id
#   labels         = ["default"]

#   route {
#     name              = "route"
#     destinations_type = "CIDR"
#     destinations      = ["10.0.0.0/16"]
#     next_hop_type     = "ResourceId"
#     next_hop          = azurerm_virtual_hub_connection.app_vnet.id
#   }
# }
