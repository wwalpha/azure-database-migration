
variable "resource_group_name" {}

variable "resource_group_location" {}

variable "vnet_subnets" {}

variable "azurevm_admin_username" {
  default = "adminuser"
}

variable "azurevm_admin_password" {
}
