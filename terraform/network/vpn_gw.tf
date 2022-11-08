resource "azurerm_public_ip" "vgw" {
  name                = "vgw-ip"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  allocation_method = "Dynamic"
}

resource "azurerm_subnet" "gateway" {
  name                 = "GatewaySubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = ["10.0.0.0/24"]
}

resource "azurerm_virtual_network_gateway" "this" {
  name                = "vgw"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  type                = "Vpn"
  vpn_type            = "RouteBased"
  sku                 = "VpnGw1"
  active_active       = false
  enable_bgp          = false

  ip_configuration {
    name                          = "vgw-ip"
    public_ip_address_id          = azurerm_public_ip.vgw.id
    private_ip_address_allocation = "Dynamic"
    subnet_id                     = azurerm_subnet.gateway.id
  }
}

data "azurerm_client_config" "this" {}

resource "azurerm_vpn_server_configuration" "this" {
  name                     = "p2s-config"
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

resource "azurerm_virtual_wan" "this" {
  name                = "demo-virtualwan"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_hub" "this" {
  name                = "demo-virtualhub"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  virtual_wan_id      = azurerm_virtual_wan.this.id
  address_prefix      = "10.20.0.0/16"
}

resource "azurerm_point_to_site_vpn_gateway" "this" {
  name                        = "p2s-vpn-gateway"
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
