locals {
  subscription_id                      = data.azurerm_subscription.current.subscription_id
  service_endpoint_storage_policy_name = "database_storage"
  service_endpoint_storage_policy_id   = "/subscriptions/${local.subscription_id}/resourceGroups/${var.resource_group_name}/providers/Microsoft.Network/serviceEndpointPolicies/${local.service_endpoint_storage_policy_name}"
}

data "azurerm_subscription" "current" {}
