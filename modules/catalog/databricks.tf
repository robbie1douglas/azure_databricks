# Must be a Databricks Account Admin if using a service principal to do this
resource "databricks_storage_credential" "external" {
  name = var.databricks_access_connector_name
  azure_managed_identity {
    access_connector_id = var.databricks_access_connector_id
  }
  comment = "Managed by TF"
}

# Requires CREATE EXTERNAL LOCATION on the metastore
resource "databricks_external_location" "this" {
  name = format("%s-%s",
    var.adls_name,
    var.storage_account_name
  )
  url = format("abfss://%s@%s.dfs.core.windows.net",
    var.adls_name,
    var.storage_account_name
  )

  credential_name = databricks_storage_credential.external.id
  comment         = "Managed by Terraform"
}

# Requires CREATE CATALOG on the metastore
resource "databricks_catalog" "this" {
  name = var.databricks_workspace_name
  storage_root = format("abfss://%s@%s.dfs.core.windows.net",
    var.adls_name,
    var.storage_account_name
  )
  isolation_mode = "ISOLATED"
  comment        = "Managed by Terraform"
  properties = {
    workspace = "${var.databricks_workspace_name}"
  }
}
