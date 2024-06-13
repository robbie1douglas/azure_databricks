output "databricks_workspace_url" {
  value = azurerm_databricks_workspace.this.workspace_url
}

output "databricks_workspace_name" {
  value = azurerm_databricks_workspace.this.name
}

output "databricks_access_connector_name" {
  value = azurerm_databricks_access_connector.ext_access_connector.name
}

output "databricks_access_connector_id" {
  value = azurerm_databricks_access_connector.ext_access_connector.id
}

output "adls_name" {
  value = azurerm_storage_data_lake_gen2_filesystem.this.name
}

output "storage_account_name" {
  value = azurerm_storage_account.ext_storage.name
}
