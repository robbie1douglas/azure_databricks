# azure_databricks/modules/base
This will create the base resources needed to create a Databricks workspace.

## Sample deployment
```
module "base" {
  source                    = "../../modules/base"
  client_name               = var.client_name
  project_name              = var.project_name
  service_principal_name    = var.service_principal_name
  resource_group_location   = var.resource_group_location
  vnet_cidr                 = var.vnet_cidr
  azuredatabricks_principle = var.azuredatabricks_principle
  tags                      = var.tags
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azuread"></a> [azuread](#provider\_azuread) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |
| <a name="provider_http"></a> [http](#provider\_http) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_key_vault.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault) | resource |
| [azurerm_key_vault_access_policy.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.databricks_principle](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_key_vault_access_policy.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/key_vault_access_policy) | resource |
| [azurerm_network_security_group.this_databricks_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_network_security_group.this_nsg](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/network_security_group) | resource |
| [azurerm_private_dns_zone.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/private_dns_zone) | resource |
| [azurerm_resource_group.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [azurerm_role_assignment.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.this_access_admin](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.this_access_admin_current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_role_assignment.this_current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/role_assignment) | resource |
| [azurerm_route_table.this_rt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/route_table) | resource |
| [azurerm_subnet.this_databricks_private_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.this_databricks_public_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.this_se_subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet_network_security_group_association.this_databricks_private_nsg_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.this_databricks_public_nsg_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_network_security_group_association.this_se_nsg_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_network_security_group_association) | resource |
| [azurerm_subnet_route_table_association.this_databricks_private_rtb_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subnet_route_table_association.this_databricks_public_rtb_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_subnet_route_table_association.this_se_rtb_association](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet_route_table_association) | resource |
| [azurerm_virtual_network.this_vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |
| [azuread_service_principal.this](https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/service_principal) | data source |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [http_http.ipinfo](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_azuredatabricks_principle"></a> [azuredatabricks\_principle](#input\_azuredatabricks\_principle) | The principle ID of the databricks service | `any` | n/a | yes |
| <a name="input_client_name"></a> [client\_name](#input\_client\_name) | Name of client | `any` | n/a | yes |
| <a name="input_databricks_private_subnet_cidr"></a> [databricks\_private\_subnet\_cidr](#input\_databricks\_private\_subnet\_cidr) | cidr for the private databricks subnet | `string` | `""` | no |
| <a name="input_databricks_public_subnet_cidr"></a> [databricks\_public\_subnet\_cidr](#input\_databricks\_public\_subnet\_cidr) | cidr for the public databricks subnet | `string` | `""` | no |
| <a name="input_ip_rules"></a> [ip\_rules](#input\_ip\_rules) | IPs that are allowed to access key vault | `list(string)` | `[]` | no |
| <a name="input_project_name"></a> [project\_name](#input\_project\_name) | Name of project | `any` | n/a | yes |
| <a name="input_purge_protection_enabled"></a> [purge\_protection\_enabled](#input\_purge\_protection\_enabled) | n/a | `bool` | `true` | no |
| <a name="input_resource_group_location"></a> [resource\_group\_location](#input\_resource\_group\_location) | Location of the resource group | `any` | n/a | yes |
| <a name="input_se_subnet_cidr"></a> [se\_subnet\_cidr](#input\_se\_subnet\_cidr) | cidr for the service endpoint subnet | `string` | `""` | no |
| <a name="input_service_principal_name"></a> [service\_principal\_name](#input\_service\_principal\_name) | The name of the service principal that will be deploying the Databricks resources on top of these resources | `any` | n/a | yes |
| <a name="input_soft_delete_retention_days"></a> [soft\_delete\_retention\_days](#input\_soft\_delete\_retention\_days) | n/a | `number` | `7` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | Tags that need to be applied to all resources | `map(any)` | n/a | yes |
| <a name="input_vnet_cidr"></a> [vnet\_cidr](#input\_vnet\_cidr) | The CIDR to be used by the vnet | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_databricks_private_subnet_name"></a> [databricks\_private\_subnet\_name](#output\_databricks\_private\_subnet\_name) | n/a |
| <a name="output_databricks_public_subnet_name"></a> [databricks\_public\_subnet\_name](#output\_databricks\_public\_subnet\_name) | n/a |
| <a name="output_key_vault_name"></a> [key\_vault\_name](#output\_key\_vault\_name) | n/a |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
| <a name="output_se_subnet_name"></a> [se\_subnet\_name](#output\_se\_subnet\_name) | n/a |
| <a name="output_vnet_name"></a> [vnet\_name](#output\_vnet\_name) | n/a |
<!-- END_TF_DOCS -->