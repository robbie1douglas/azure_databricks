# azure_databricks/modules/workspace

## Sample deployment
```
module "databricks_workspace" {
  source                         = "../../modules/workspace"
  client_name                    = var.client_name
  project_name                   = var.project_name
  resource_group_name            = var.resource_group_name
  vnet_name                      = var.vnet_name
  key_vault_name                 = var.key_vault_name
  workspace_name                 = var.workspace_name
  metastore_name                 = var.metastore_name
  databricks_public_subnet_name  = var.databricks_public_subnet_name
  databricks_private_subnet_name = var.databricks_private_subnet_name
  se_subnet_name                 = var.se_subnet_name
  private_dns_zone_name          = var.private_dns_zone_name
  service_principal_name         = var.service_principal_name
  tags                           = var.tags
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | ~>3.97.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | ~>3.97.0 |
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_databricks_access_connector.ext_access_connector](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_access_connector) | resource |
| [azurerm_databricks_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_workspace) | resource |
| [azurerm_databricks_workspace_customer_managed_key.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_workspace_customer_managed_key) | resource |
| [azurerm_key_vault_access_policy.databricks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_key.cmk](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_key) | resource |
| [azurerm_private_endpoint.databricks](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_endpoint) | resource |
| [azurerm_role_assignment.dbx_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.ext_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_storage_account.ext_storage](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_account) | resource |
| [azurerm_storage_data_lake_gen2_filesystem.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_data_lake_gen2_filesystem) | resource |
| [databricks_metastore_assignment.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/metastore_assignment) | resource |
| [azuread_service_principal.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/key_vault) | data source |
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/private_dns_zone) | data source |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/resource_group) | data source |
| [azurerm_subnet.prv](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.pub](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_subnet.se](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subnet) | data source |
| [azurerm_virtual_network.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/virtual_network) | data source |
| [databricks_metastore.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/data-sources/metastore) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_name"></a> [client\_name](#input\_client\_name) | Name of client | `any` | n/a | yes |
| <a name="input_databricks_private_subnet_name"></a> [databricks\_private\_subnet\_name](#input\_databricks\_private\_subnet\_name) | Name of Databricks private subnet | `any` | n/a | yes |
| <a name="input_databricks_public_subnet_name"></a> [databricks\_public\_subnet\_name](#input\_databricks\_public\_subnet\_name) | Name of Databricks public subnet | `any` | n/a | yes |
| <a name="input_key_vault_name"></a> [key\_vault\_name](#input\_key\_vault\_name) | Name of key vault | `any` | n/a | yes |
| <a name="input_metastore_name"></a> [metastore\_name](#input\_metastore\_name) | Name of Databricks Metastore | `any` | n/a | yes |
| <a name="input_private_dns_zone_name"></a> [private\_dns\_zone\_name](#input\_private\_dns\_zone\_name) | Name of the private dns zone name | `string` | `"privatelink.azuredatabricks.net"` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of project | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | Name of the resource group | `any` | n/a | yes |
| <a name="input_se_subnet_name"></a> [se\_subnet\_name](#input\_se\_subnet\_name) | Name of the service endpoint subnet | `any` | n/a | yes |
| <a name="input_service_principal_name"></a> [service\_principal\_name](#input\_service\_principal\_name) | The name of the service principal that will be deploying the Databricks storage credential, external location and catalog | `any` | n/a | yes |
| <a name="input_sku"></a> [sku](#input\_sku) | SKU of the databricks workspace | `string` | `"premium"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags that need to be applied to all resources | `map(any)` | n/a | yes |
| <a name="input_vnet_name"></a> [vnet\_name](#input\_vnet\_name) | Name of the VNet | `any` | n/a | yes |
| <a name="input_workspace_name"></a> [workspace\_name](#input\_workspace\_name) | Name of Databricks workspace. Will be concatonated with client\_name and project\_name in naming conventions. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_adls_name"></a> [adls\_name](#output\_adls\_name) | n/a |
| <a name="output_databricks_access_connector_id"></a> [databricks\_access\_connector\_id](#output\_databricks\_access\_connector\_id) | n/a |
| <a name="output_databricks_access_connector_name"></a> [databricks\_access\_connector\_name](#output\_databricks\_access\_connector\_name) | n/a |
| <a name="output_databricks_workspace_name"></a> [databricks\_workspace\_name](#output\_databricks\_workspace\_name) | n/a |
| <a name="output_databricks_workspace_url"></a> [databricks\_workspace\_url](#output\_databricks\_workspace\_url) | n/a |
| <a name="output_storage_account_name"></a> [storage\_account\_name](#output\_storage\_account\_name) | n/a |
<!-- END_TF_DOCS -->