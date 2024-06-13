data "azurerm_client_config" "current" {}

data "http" "ipinfo" {
  url = "https://ipinfo.io"
}

data "azuread_service_principal" "this" {
  display_name = var.service_principal_name
}

resource "azurerm_key_vault" "this" {
  name                        = format("%s-%s-kv", var.client_name, var.project_name)
  location                    = azurerm_resource_group.this.location
  resource_group_name         = azurerm_resource_group.this.name
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  sku_name                    = "standard"
  enabled_for_disk_encryption = true
  enable_rbac_authorization   = true
  purge_protection_enabled    = var.purge_protection_enabled
  soft_delete_retention_days  = var.soft_delete_retention_days

  network_acls {
    bypass         = "AzureServices"
    default_action = "Deny"
    ip_rules = [
      jsondecode(data.http.ipinfo.body).ip
    ]
    virtual_network_subnet_ids = [
      azurerm_subnet.this_databricks_private_subnet.id
    ]
  }
}

resource "azurerm_role_assignment" "this" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azuread_service_principal.this.object_id
}

resource "azurerm_role_assignment" "this_access_admin" {
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Data Access Administrator"
  principal_id         = data.azuread_service_principal.this.object_id
}

resource "azurerm_role_assignment" "this_current" {
  count                = data.azuread_service_principal.this.object_id != data.azurerm_client_config.current.object_id ? 1 : 0
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_role_assignment" "this_access_admin_current" {
  count                = data.azuread_service_principal.this.object_id != data.azurerm_client_config.current.object_id ? 1 : 0
  scope                = azurerm_key_vault.this.id
  role_definition_name = "Key Vault Data Access Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

resource "azurerm_key_vault_access_policy" "databricks_principle" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = var.azuredatabricks_principle

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

resource "azurerm_key_vault_access_policy" "current" {
  count        = data.azuread_service_principal.this.object_id != data.azurerm_client_config.current.object_id ? 1 : 0
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get",
    "Create",
    "Delete",
    "List",
    "Restore",
    "Recover",
    "UnwrapKey",
    "WrapKey",
    "Purge",
    "Encrypt",
    "Decrypt",
    "Sign",
    "Verify",
    "GetRotationPolicy",
    "SetRotationPolicy"
  ]
  secret_permissions = ["Get", "Set"]
}

resource "azurerm_key_vault_access_policy" "this" {
  key_vault_id = azurerm_key_vault.this.id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azuread_service_principal.this.object_id

  key_permissions = [
    "Get",
    "Create",
    "Delete",
    "List",
    "Restore",
    "Recover",
    "UnwrapKey",
    "WrapKey",
    "Purge",
    "Encrypt",
    "Decrypt",
    "Sign",
    "Verify",
    "GetRotationPolicy",
    "SetRotationPolicy"
  ]
  secret_permissions = ["Get", "Set"]
}
