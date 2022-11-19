variable "azurevm_admin_username" {}

variable "azurevm_admin_password" {}

variable "mssql_admin_username" {}

variable "mssql_admin_password" {}

variable "azure_vm_image_database" {
  default = "win2012-sqlserver2012-adventuresV2"
}

variable "azure_vm_image_resource_group" {
  default = "DEV_RG"
}

variable "my_ip_address" {
  default = "202.32.14.177"
}
