terraform {
  backend "remote" {
    organization = "wwalpha"

    workspaces {
      name = "azure-database-migration-simple"
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
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  use_msi = true
}

resource "azurerm_resource_group" "this" {
  name     = "DEMO_RG1"
  location = "Japan East"
}

module "database" {
  source = "./database"

  resource_group_name     = azurerm_resource_group.this.name
  resource_group_location = azurerm_resource_group.this.location
}

module "networking" {
  depends_on = [module.database]
  source     = "./networking"

  resource_group_name     = azurerm_resource_group.this.name
  resource_group_location = azurerm_resource_group.this.location
  mssql_server_id         = module.database.mssql_server_id
}

module "computing" {
  source = "./computing"

  resource_group_name     = azurerm_resource_group.this.name
  resource_group_location = azurerm_resource_group.this.location
  vnet_subnets            = module.networking.vnet_subnets
}
