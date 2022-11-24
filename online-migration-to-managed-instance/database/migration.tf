resource "null_resource" "dbms" {
  triggers = {
    file_content_md5 = md5(file("${path.module}/scripts/datamigration.sh"))
  }

  provisioner "local-exec" {
    command = "sh ${path.module}/scripts/datamigration.sh"

    environment = {
      LOCATION       = var.resource_group_location
      RESOURCE_GROUP = var.resource_group_name
      NAME           = "dbms-${var.suffix}"
    }
  }
}

data "external" "shir_keys" {
  count      = var.is_show_shir_key ? 1 : 0
  depends_on = [null_resource.dbms]
  program    = ["sh", "${path.module}/scripts/list_auth_key.sh"]

  query = {
    RESOURCE_GROUP = var.resource_group_name
    DBMS_NAME      = "dbms-${var.suffix}"
  }
}
