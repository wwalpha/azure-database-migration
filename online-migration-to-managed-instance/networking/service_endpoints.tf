resource "null_resource" "service_endpoint_policy" {
  triggers = {
    file_content_md5    = md5(file("${path.module}/scripts/sep_create.sh"))
    resource_group_name = var.resource_group_name
    policy_name         = local.service_endpoint_storage_policy_name
  }

  provisioner "local-exec" {
    when    = create
    command = "sh ${path.module}/scripts/sep_create.sh"

    environment = {
      RESOURCE_GROUP     = self.triggers.resource_group_name
      POLICY_NAME        = self.triggers.policy_name
      STORAGE_ACCOUNT_ID = var.storage_account_id
    }
  }

  provisioner "local-exec" {
    when    = destroy
    command = "sh ${path.module}/scripts/sep_destroy.sh"

    environment = {
      RESOURCE_GROUP = self.triggers.resource_group_name
      POLICY_NAME    = self.triggers.policy_name
    }
  }
}
