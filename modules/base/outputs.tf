output "resource_group_name" {
  value = azurerm_resource_group.this.name
}

output "vnet_name" {
  value = azurerm_virtual_network.this_vnet.name
}

output "key_vault_name" {
  value = azurerm_key_vault.this.name
}

output "databricks_public_subnet_name" {
  value = azurerm_subnet.this_databricks_public_subnet.name
}

output "databricks_private_subnet_name" {
  value = azurerm_subnet.this_databricks_private_subnet.name
}

output "se_subnet_name" {
  value = azurerm_subnet.this_se_subnet.name
}
