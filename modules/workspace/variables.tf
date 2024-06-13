variable "client_name" {
  description = "Name of client"
}

variable "project_name" {
  description = "Name of project"
}

variable "service_principal_name" {
  description = "The name of the service principal that will be deploying the Databricks storage credential, external location and catalog"
}

variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "vnet_name" {
  description = "Name of the VNet"
}

variable "key_vault_name" {
  description = "Name of key vault"
}

variable "databricks_public_subnet_name" {
  description = "Name of Databricks public subnet"
}

variable "databricks_private_subnet_name" {
  description = "Name of Databricks private subnet"
}

variable "se_subnet_name" {
  description = "Name of the service endpoint subnet"
}

variable "metastore_name" {
  description = "Name of Databricks Metastore"
}

variable "workspace_name" {
  description = "Name of Databricks workspace. Will be concatonated with client_name and project_name in naming conventions."
}

variable "sku" {
  description = "SKU of the databricks workspace"
  default     = "premium"
}

variable "private_dns_zone_name" {
  description = "Name of the private dns zone name"
  default     = "privatelink.azuredatabricks.net"
}

variable "tags" {
  description = "Tags that need to be applied to all resources"
  type        = map(any)
}
