resource "azurerm_resource_group" "this" {
  location = var.resource_group_location
  name     = format("%s-%s-rg", var.client_name, var.project_name)
  tags = {
    Provisioner = "Terraform"
    Client      = var.client_name
    Project     = var.project_name
  }
}
