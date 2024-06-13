resource "azurerm_databricks_workspace" "this" {
  name                                  = "${lower(var.client_name)}-${lower(var.project_name)}-${lower(var.workspace_name)}-dbxwsp"
  resource_group_name                   = data.azurerm_resource_group.this.name
  location                              = data.azurerm_resource_group.this.location
  sku                                   = var.sku
  managed_resource_group_name           = "${lower(var.client_name)}-${lower(var.project_name)}-${lower(var.workspace_name)}-managed-databricks-rg"
  public_network_access_enabled         = true
  network_security_group_rules_required = "NoAzureDatabricksRules"
  customer_managed_key_enabled          = true

  custom_parameters {
    no_public_ip        = true
    public_subnet_name  = var.databricks_public_subnet_name
    private_subnet_name = var.databricks_private_subnet_name
    virtual_network_id  = data.azurerm_virtual_network.this.id

    public_subnet_network_security_group_association_id  = data.azurerm_subnet.pub.id
    private_subnet_network_security_group_association_id = data.azurerm_subnet.prv.id
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "databricks" {
  depends_on = [
    azurerm_databricks_workspace.this,
    azurerm_databricks_workspace_customer_managed_key.this
  ]
  name                = "${lower(var.client_name)}-${lower(var.project_name)}-${lower(var.workspace_name)}-pe-dbx"
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  subnet_id           = data.azurerm_subnet.se.id

  private_service_connection {
    name                           = "${lower(var.client_name)}-${lower(var.project_name)}-${lower(var.workspace_name)}-psc"
    is_manual_connection           = false
    private_connection_resource_id = azurerm_databricks_workspace.this.id
    subresource_names              = ["databricks_ui_api"]
  }

  private_dns_zone_group {
    name                 = "private-dns-zone-uiapi"
    private_dns_zone_ids = [data.azurerm_private_dns_zone.this.id]
  }
}

resource "databricks_metastore_assignment" "this" {
  workspace_id = azurerm_databricks_workspace.this.workspace_id
  metastore_id = data.databricks_metastore.this.id
}
