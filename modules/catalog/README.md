# azure_databricks/modules/catalog

## Sample Deployment
```
module "databricks_catalog" {
  source                           = "../../modules/catalog"
  databricks_workspace_url         = var.databricks_workspace_url
  databricks_workspace_name        = var.databricks_workspace_name
  databricks_access_connector_name = var.databricks_access_connector_name
  databricks_access_connector_id   = var.databricks_access_connector_id
  adls_name                        = var.adls_name
  storage_account_name             = var.storage_account_name
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
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [databricks_catalog.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/catalog) | resource |
| [databricks_external_location.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/external_location) | resource |
| [databricks_storage_credential.external](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/storage_credential) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_adls_name"></a> [adls\_name](#input\_adls\_name) | Name of the ADLS | `any` | n/a | yes |
| <a name="input_databricks_access_connector_id"></a> [databricks\_access\_connector\_id](#input\_databricks\_access\_connector\_id) | Id of the Databricks access connector | `any` | n/a | yes |
| <a name="input_databricks_access_connector_name"></a> [databricks\_access\_connector\_name](#input\_databricks\_access\_connector\_name) | Name of the Databricks access connector | `any` | n/a | yes |
| <a name="input_databricks_workspace_name"></a> [databricks\_workspace\_name](#input\_databricks\_workspace\_name) | Name of the Databricks workspace | `any` | n/a | yes |
| <a name="input_databricks_workspace_url"></a> [databricks\_workspace\_url](#input\_databricks\_workspace\_url) | URL of the Databricks workspace | `any` | n/a | yes |
| <a name="input_storage_account_name"></a> [storage\_account\_name](#input\_storage\_account\_name) | Name of the storage account | `any` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->