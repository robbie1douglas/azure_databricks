resource "azurerm_key_vault_key" "cmk" {
  name         = "${lower(var.client_name)}-${lower(var.project_name)}-cmk"
  key_vault_id = data.azurerm_key_vault.this.id
  key_type     = "RSA"
  key_size     = 2048
  key_opts     = ["decrypt", "encrypt", "sign", "unwrapKey", "verify", "wrapKey"]

  expiration_date = timeadd(timestamp(), "17520h") # two years

  lifecycle {
    ignore_changes = [
      expiration_date
    ]
  }
}

resource "azurerm_databricks_workspace_customer_managed_key" "this" {
  workspace_id     = azurerm_databricks_workspace.this.id
  key_vault_key_id = azurerm_key_vault_key.cmk.id
}

resource "azurerm_role_assignment" "this" {
  scope                = data.azurerm_key_vault.this.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = azurerm_databricks_workspace.this.storage_account_identity.0.principal_id
}

resource "azurerm_key_vault_access_policy" "databricks" {
  depends_on = [azurerm_databricks_workspace.this]

  key_vault_id = data.azurerm_key_vault.this.id
  tenant_id    = azurerm_databricks_workspace.this.storage_account_identity.0.tenant_id
  object_id    = azurerm_databricks_workspace.this.storage_account_identity.0.principal_id

  key_permissions = [
    "Create",
    "Delete",
    "Get",
    "Purge",
    "Recover",
    "Update",
    "List",
    "Decrypt",
    "Sign",
    "WrapKey",
    "UnwrapKey"
  ]
}
