terraform {
  backend "remote" {
    organization = "wwalpha"

    workspaces {
      name = "azure-online-migration-to-managed-instance"
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
  depends_on = [random_id.this]
  name       = "online-migration-${local.suffix}"
  location   = "Japan East"
}

module "networking" {
  source = "./networking"

  tenant_id               = local.tenant_id
  resource_group_name     = azurerm_resource_group.this.name
  resource_group_location = azurerm_resource_group.this.location
  suffix                  = local.suffix
}

module "database" {
  source = "./database"

  resource_group_name     = azurerm_resource_group.this.name
  resource_group_location = azurerm_resource_group.this.location
  vnet_id                 = module.networking.managed_instance_database_vnet_id
  subnet_id               = module.networking.managed_instance_database_subnet_id
  mssql_admin_username    = var.mssql_admin_username
  mssql_admin_password    = var.mssql_admin_password
  suffix                  = local.suffix
}

module "storage" {
  source = "./storage"

  resource_group_name     = azurerm_resource_group.this.name
  resource_group_location = azurerm_resource_group.this.location
  sqlserver_vnet_id       = module.networking.sqlserver_vnet_id
  sqlserver_subnet_id     = module.networking.sqlserver_subnet_id
  suffix                  = local.suffix
}

module "computing" {
  source = "./computing"

  resource_group_name           = azurerm_resource_group.this.name
  resource_group_location       = azurerm_resource_group.this.location
  azure_vm_image_resource_group = var.azure_vm_image_resource_group
  azure_vm_image_database       = var.azure_vm_image_database
  azurevm_admin_username        = var.azurevm_admin_username
  azurevm_admin_password        = var.azurevm_admin_password
  sqlserver_vnet_id             = module.networking.sqlserver_vnet_id
  sqlserver_subnet_id           = module.networking.sqlserver_subnet_id
  suffix                        = local.suffix
}

