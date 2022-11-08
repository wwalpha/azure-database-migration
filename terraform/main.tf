terraform {
  backend "remote" {
    organization = "wwalpha"

    workspaces {
      name = "azure-database-migration"
    }
  }

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">3.0.0"
    }
  }
}

provider "azurerm" {
  features {}

  use_msi = true
}

resource "azurerm_resource_group" "this" {
  name     = "DEMO_RG"
  location = "Japan East"
}

module "network" {
  depends_on = [module.database]
  source     = "./network"

  resource_group_name     = azurerm_resource_group.this.name
  resource_group_location = azurerm_resource_group.this.location
  mssql_server_id         = module.database.mssql_server_id
}

module "computing" {
  source = "./computing"

  resource_group_name     = azurerm_resource_group.this.name
  resource_group_location = azurerm_resource_group.this.location
  vnet_subnets            = module.network.vnet_subnets
}

module "database" {
  source = "./database"

  resource_group_name     = azurerm_resource_group.this.name
  resource_group_location = azurerm_resource_group.this.location
}
