data "azuread_service_principal" "this" {
  display_name = var.service_principal_name
}

resource "azurerm_storage_account" "ext_storage" {
  name                     = "${replace(var.project_name, "[^A-Za-z0-9]", "")}dbxextstr"
  resource_group_name      = data.azurerm_resource_group.this.name
  location                 = data.azurerm_resource_group.this.location
  tags                     = var.tags
  account_tier             = "Standard"
  account_replication_type = "GRS"
  is_hns_enabled           = true
}

resource "azurerm_storage_data_lake_gen2_filesystem" "this" {
  name               = "${var.project_name}-adls"
  storage_account_id = azurerm_storage_account.ext_storage.id
}

resource "azurerm_databricks_access_connector" "ext_access_connector" {
  name                = "${azurerm_databricks_workspace.this.name}-acccon-mi"
  resource_group_name = data.azurerm_resource_group.this.name
  location            = data.azurerm_resource_group.this.location
  identity {
    type = "SystemAssigned"
  }
}

# Permissions to do this are not included in Contributor only - needs Microsoft.Authorization/roleAssignments/write over the storage account
resource "azurerm_role_assignment" "ext_storage" {
  scope                = azurerm_storage_account.ext_storage.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_databricks_access_connector.ext_access_connector.identity[0].principal_id
}

resource "azurerm_role_assignment" "dbx_admin" {
  scope                = azurerm_storage_account.ext_storage.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = data.azuread_service_principal.this.object_id
}
