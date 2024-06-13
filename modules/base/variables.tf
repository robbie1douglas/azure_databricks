variable "client_name" {
  description = "Name of client"
}

variable "project_name" {
  description = "Name of project"
}

variable "resource_group_location" {
  description = "Location of the resource group"
}

variable "service_principal_name" {
  description = "The name of the service principal that will be deploying the Databricks resources on top of these resources"
}

variable "vnet_cidr" {
  description = "The CIDR to be used by the vnet"
}

variable "purge_protection_enabled" {
  default = true
}

variable "soft_delete_retention_days" {
  default = 7
}

variable "ip_rules" {
  description = "IPs that are allowed to access key vault"
  type        = list(string)
  default     = []
}

variable "databricks_public_subnet_cidr" {
  description = "cidr for the public databricks subnet"
  default     = ""
}

variable "databricks_private_subnet_cidr" {
  description = "cidr for the private databricks subnet"
  default     = ""
}

variable "se_subnet_cidr" {
  description = "cidr for the service endpoint subnet"
  default     = ""
}

variable "azuredatabricks_principle" {
  description = "The principle ID of the databricks service"
}

variable "tags" {
  description = "Tags that need to be applied to all resources"
  type        = map(any)
}
