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
  my_ip_address           = var.my_ip_address
}

module "database" {
  source = "./database"

  resource_group_name            = azurerm_resource_group.this.name
  resource_group_location        = azurerm_resource_group.this.location
  sql_managed_instance_subnet_id = module.networking.sql_managed_instance_subnet.id
  migration_subnet_id            = module.networking.migration_subnet.id
  mssql_admin_username           = var.mssql_admin_username
  mssql_admin_password           = var.mssql_admin_password
  suffix                         = local.suffix
}

module "storage" {
  source = "./storage"

  resource_group_name     = azurerm_resource_group.this.name
  resource_group_location = azurerm_resource_group.this.location
  migration_vnet_id       = module.networking.migration_vnet.id
  migration_subnet_id     = module.networking.migration_subnet.id
  suffix                  = local.suffix
}

module "computing" {
  source = "./computing"

  resource_group_name           = azurerm_resource_group.this.name
  resource_group_location       = azurerm_resource_group.this.location
  azure_vm_image_resource_group = var.azure_vm_image_resource_group
  azure_vm_image_database       = var.azure_vm_image_database
  azure_vm_image_self_hosted_ir = var.azure_vm_image_self_hosted_ir
  azurevm_admin_username        = var.azurevm_admin_username
  azurevm_admin_password        = var.azurevm_admin_password
  sqlserver_subnet_id           = module.networking.sqlserver_subnet.id
  migration_subnet_id           = module.networking.migration_subnet.id
  suffix                        = local.suffix
}
